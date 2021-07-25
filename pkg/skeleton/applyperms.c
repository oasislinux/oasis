/*
See LICENSE file for copyright and license details.

This program is meant to be run by a git hook to fix the permissions of files
based on a .perms file in the repository

It can also be run with the -d flag on any directory containing .perms in order
to apply the permissions specified by that file.

Security considerations:
If the repository previously contained a world or group readable directory which
has become secret, the names of the new files in that directory will become
temporarily visible because git checks out the files before this program is run.
*/
#define _POSIX_C_SOURCE 200809L
#include <errno.h>
#include <fcntl.h>
#include <libgen.h>
#include <spawn.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdnoreturn.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>

#define PERMS_FILE ".perms"

struct perm {
	char *name;
	mode_t mode;
	bool attempted;  /* whether we attempted to set permissions for this file */
	bool delete;     /* marked for directories that only appear in old .perms */
};

struct special {
	struct perm *perms;
	int len;
};

extern char **environ;

static char *prog;
static dev_t rootdev;
static int rootfd = AT_FDCWD;
static struct special oldsp, newsp;
static int status;

static void
verror(char *fmt, va_list ap)
{
	status = 1;
	vfprintf(stderr, fmt, ap);
	if (fmt[0] && fmt[strlen(fmt)-1] == ':')
		fprintf(stderr, " %s", strerror(errno));
	fputc('\n', stderr);
}

static void
error(char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	verror(fmt, ap);
	va_end(ap);
}

static noreturn void
die(char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	verror(fmt, ap);
	va_end(ap);

	exit(1);
}

static FILE *
spawn(char **argv, pid_t *pid)
{
	FILE *f;
	int fd[2];
	posix_spawn_file_actions_t actions;

	if (pipe(fd) < 0)
		die("pipe:");
	f = fdopen(fd[0], "r");
	if (!f)
		die("fdopen:");
	if ((errno = posix_spawn_file_actions_init(&actions)) > 0)
		die("posix_spawn_file_actions_init:");
	if ((errno = posix_spawn_file_actions_addclose(&actions, fd[0])) > 0)
		die("posix_spawn_file_actions_adddup2:");
	if ((errno = posix_spawn_file_actions_adddup2(&actions, fd[1], 1)) > 0)
		die("posix_spawn_file_actions_adddup2:");
	if ((errno = posix_spawnp(pid, argv[0], &actions, NULL, argv, environ)) > 0)
		die("posix_spawnp %s:", argv[0]);
	posix_spawn_file_actions_destroy(&actions);
	close(fd[1]);

	return f;
}

static void
readspecial(struct special *sp, FILE *f)
{
	char *line = NULL, *s, *mode;
	size_t size = 0;
	ssize_t n;

	while ((n = getline(&line, &size, f)) >= 0) {
		if (line[n-1] == '\n')
			line[--n] = '\0';
		mode = s = line;
		s = strchr(s, ' ');
		if (!s || s == mode)
			die("malformed permissions file: %s", PERMS_FILE);
		*s++ = '\0';
		sp->perms = realloc(sp->perms, (sp->len + 1) * sizeof(*sp->perms));
		if (!sp->perms)
			die("realloc:");
		sp->perms[sp->len] = (struct perm){
			.name = strdup(s),
			.mode = strtoul(mode, &s, 8),
		};
		if (!sp->perms[sp->len].name)
			die("strdup:");
		if (*s)
			die("invalid mode: %s", mode);
		++sp->len;
	}
}

static void
gitspecial(struct special *sp, const char *rev)
{
	char object[41 + sizeof(PERMS_FILE)];
	char *argv[] = {"git", "show", object, 0};
	FILE *f;
	pid_t pid;
	int st, n;

	n = snprintf(object, sizeof(object), "%s:%s", rev, PERMS_FILE);
	if (n < 0 || n >= (int)sizeof(object))
		die("revision is too large: %s", rev);
	f = spawn(argv, &pid);
	readspecial(sp, f);
	fclose(f);

	if (waitpid(pid, &st, 0) < 0)
		die("waitpid:");
	if (!(WIFEXITED(st) && WEXITSTATUS(st) == 0))
		die("child process failed");
}

static int
chmod_v(const char *path, mode_t mode)
{
	printf("chmod(\"%s\", %#o)\n", path, mode);
	return fchmodat(rootfd, path, mode, 0);
}

static int
mkdir_v(const char *path, mode_t mode)
{
	printf("mkdir(\"%s\", %#o)\n", path, mode);
	return mkdirat(rootfd, path, mode);
}

static int
rmdir_v(const char *path)
{
	printf("rmdir(\"%s\")\n", path);
	return unlinkat(rootfd, path, AT_REMOVEDIR);
}

static int
defperm(const char *name)
{
	struct stat st;
	mode_t mode;

	if (fstatat(rootfd, name, &st, AT_SYMLINK_NOFOLLOW) < 0)
		return -1;
	if (st.st_dev != rootdev) {
		errno = EXDEV;
		return -1;
	}
	switch (st.st_mode & S_IFMT) {
	case S_IFREG:
		mode = st.st_mode & S_IXUSR ? 0755 : 0644;
		break;
	case S_IFDIR:
		mode = 0755;
		break;
	case S_IFLNK:
		return 0;
	default:
		errno = EINVAL;
		return -1;
	}
	if ((st.st_mode & ~S_IFMT) == mode)
		return 0;
	return chmod_v(name, mode);
}

static int
specialperm(struct perm *p)
{
	struct stat st;

	if (p->attempted)
		return 0;
	p->attempted = true;
	if (fstatat(rootfd, p->name, &st, AT_SYMLINK_NOFOLLOW) < 0) {
		if (errno != ENOENT || !S_ISDIR(p->mode))
			return -1;
		return mkdir_v(p->name, p->mode & ~S_IFMT);
	}
	if (st.st_dev != rootdev) {
		errno = EXDEV;
		return -1;
	}
	if (st.st_mode == p->mode)
		return 0;
	if ((st.st_mode & S_IFMT) != (p->mode & S_IFMT)) {
		errno = EINVAL;
		return -1;
	}
	return chmod_v(p->name, p->mode & ~S_IFMT);
}

static void
specialperms(void)
{
	int i = 0, j = 0, n;

	while (i < oldsp.len || j < newsp.len) {
		if (i == oldsp.len)
			n = 1;
		else if (j == newsp.len)
			n = -1;
		else
			n = strcmp(oldsp.perms[i].name, newsp.perms[j].name);
		if (n >= 0) {
			if (specialperm(&newsp.perms[j]) < 0 && errno != EXDEV)
				error("specialperm:");
			++j;
			if (n == 0)
				++i;
			continue;
		}
		if ((oldsp.perms[i].mode & S_IFMT) == S_IFDIR) {
			oldsp.perms[i].delete = true;
		} else if (defperm(oldsp.perms[i].name) < 0) {
			switch (errno) {
			case ENOENT:
			case EXDEV:
				break;
			default:
				error("defperm:");
			}
		}
		++i;
	}
	/* delete directories in reverse order */
	while (i > 0) {
		--i;
		if (oldsp.perms[i].delete && rmdir_v(oldsp.perms[i].name) < 0) {
			switch (errno) {
			case ENOENT:
			case ENOTEMPTY:
				break;
			default:
				error("rmdir:");
			}
		}
	}
}

static int
setperm(const char *name)
{
	int i;

	for (i = 0; i < newsp.len; ++i) {
		if (strcmp(name, newsp.perms[i].name) == 0)
			return specialperm(&newsp.perms[i]);
	}
	return defperm(name);
}

static void
setroot(const char *root)
{
	struct stat st;

	rootfd = open(root, O_RDONLY);
	if (rootfd < 0)
		die("open %s:", root);
	if (fstat(rootfd, &st) < 0)
		die("fstat:", root);
	rootdev = st.st_dev;
}

static void
gitupdate(char *old, char *new)
{
	char *argv_diff[] = {"git", "diff", "--name-only", "-z", old, new, 0};
	char *argv_new[] = {"git", "ls-tree", "--name-only", "--full-tree", "-z", "-r", new, 0};
	FILE *f;
	pid_t pid;
	struct {
		char *buf;
		size_t size;
	} lines[2] = {0};
	ssize_t n;
	int cur = 0, st;
	char *root, *path, *diff, *s;

	root = getenv("GIT_WORK_TREE");
	setroot(root ? root : ".");
	if (old)
		gitspecial(&oldsp, old);
	gitspecial(&newsp, new);

	f = spawn(old ? argv_diff : argv_new, &pid);
	umask(0);
	while ((n = getdelim(&lines[cur].buf, &lines[cur].size, '\0', f)) >= 0) {
		path = lines[cur].buf;
		if (strcmp(path, PERMS_FILE) == 0) {
			specialperms();
			continue;
		}
		if (setperm(path) < 0) switch (errno) {
		case ENOENT:
			continue;
		case EXDEV:
			break;
		default:
			error("setperm %s:", path);
		}
		/* find the first difference from the previous path */
		diff = path;
		if (lines[!cur].buf)
			for (s = lines[!cur].buf; *s && *s == *diff; ++s, ++diff);
		/* set permissions on each parent directory after that difference */
		for (s = path + n; s >= diff; --s) {
			if (*s != '/')
				continue;
			*s = '\0';
			if (setperm(path) < 0)
				error("setperm %s:", path);
			*s = '/';
		}
		cur = !cur;
	}
	fclose(f);

	if (waitpid(pid, &st, 0) < 0)
		die("waitpid:");
	if (!(WIFEXITED(st) && WEXITSTATUS(st) == 0))
		die("child process failed");
}

static void
applyspecial(void)
{
	int fd;
	FILE *f;

	fd = openat(rootfd, ".perms", O_RDONLY);
	if (fd < 0)
		die("open .perms:");
	f = fdopen(fd, "r");
	if (!f)
		die("fdopen:");
	readspecial(&newsp, f);
	fclose(f);
	umask(0);
	specialperms();
}

static void
usage(void)
{
	fprintf(stderr, "usage: %s [[old] new] | %s -d dir\n", prog, prog);
	exit(2);
}

int
main(int argc, char *argv[])
{
	int dflag = 0;
	char *old, *new;

	prog = basename(argv[0]);
	for (++argv, --argc; argc && (*argv)[0] == '-' && (*argv)[1]; ++argv, --argc) {
		switch ((*argv)[1]) {
		case 'd':
			if (!*++argv)
				usage();
			--argc;
			setroot(*argv);
			dflag = 1;
			break;
		default:
			usage();
		}
	}

	if (dflag) {
		if (argc)
			usage();
		applyspecial();
		return status;
	}

	switch (argc) {
	case 0:
		old = NULL;
		new = "HEAD";
		break;
	case 1:
		old = NULL;
		new = argv[0];
		break;
	case 2:
		old = argv[0];
		new = argv[1];
		break;
	default:
		usage();
	}
	gitupdate(old, new);
	return status;
}
