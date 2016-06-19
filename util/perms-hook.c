/*
See LICENSE file for copyright and license details.

This program is meant to be run by a git hook to fix the permissions of files
based on a .perms file in the repository

TODO: Once we start processing the list of changed files, we should keep track
of errors, but continue on to the next file.
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
	mode_t mode;
	char *name;
	bool applied;
};

struct special {
	struct perm *perms;
	int len;
};

extern char **environ;

static dev_t rootdev;
static struct special oldsp, newsp;

static noreturn void
die(char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);

	if (fmt[0] && fmt[strlen(fmt)-1] == ':')
		fprintf(stderr, " %s", strerror(errno));
	fputc('\n', stderr);

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
	if (posix_spawn_file_actions_init(&actions) < 0)
		die("posix_spawn_file_actions_init:");
	if (posix_spawn_file_actions_addclose(&actions, fd[0]) < 0)
		die("posix_spawn_file_actions_adddup2:");
	if (posix_spawn_file_actions_adddup2(&actions, fd[1], 1) < 0)
		die("posix_spawn_file_actions_adddup2:");
	if (posix_spawnp(pid, argv[0], &actions, NULL, argv, environ) < 0)
		die("posix_spawnp:");
	posix_spawn_file_actions_destroy(&actions);
	close(fd[1]);

	return f;
}

static void
readspecial(struct special *sp, const char *rev)
{
	char object[20 + sizeof(PERMS_FILE)];
	char *argv[] = {"git", "show", object, 0};
	FILE *f;
	pid_t pid;
	char *line = NULL, *s, *mode;
	size_t size = 0;
	ssize_t n;
	int st;

	if (snprintf(object, sizeof(object), "%s:%s", rev, PERMS_FILE) >= (int)sizeof(object))
		die("revision is too large: %s", rev);
	f = spawn(argv, &pid);
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
		sp->perms[sp->len].name = strdup(s);
		if (!sp->perms[sp->len].name)
			die("strdup:");
		sp->perms[sp->len].mode = strtoul(mode, &s, 8);
		sp->perms[sp->len].applied = false;
		if (*s)
			die("invalid mode: %s", mode);
		++sp->len;
	}
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
	return chmod(path, mode);
}

static int
mkdir_v(const char *path, mode_t mode)
{
	printf("mkdir(\"%s\", %#o)\n", path, mode);
	return mkdir(path, mode);
}

static int
defperm(const char *name)
{
	struct stat st;
	mode_t mode;

	if (lstat(name, &st) < 0)
		return -1;
	if (st.st_dev != rootdev) {
		errno = EXDEV;
		return -1;
	}
	switch (st.st_mode & S_IFMT) {
	case S_IFREG:
		mode = st.st_mode&S_IXUSR ? 0755 : 0644;
		break;
	case S_IFDIR:
		mode = 0755;
		break;
	case S_IFLNK:
		return 0;
	default:
		die("unexpected file type %#o: %s", st.st_mode, name);
	}
	if ((st.st_mode&~S_IFMT) == mode)
		return 0;
	if (chmod_v(name, mode) < 0)
		die("chmod:");
	return 0;
}

static void
specialperm(struct perm *p)
{
	struct stat st;

	if (lstat(p->name, &st) < 0) {
		if (errno != ENOENT)
			die("lstat:");
		if (!S_ISDIR(p->mode))
			die("file missing and not a directory: %s", p->name);
		if (mkdir_v(p->name, p->mode & ~S_IFMT) < 0)
			die("mkdir:");
		goto applied;
	}
	if (st.st_dev != rootdev)
		return;
	if (st.st_mode == p->mode)
		goto applied;
	if ((st.st_mode&S_IFMT) != (p->mode&S_IFMT))
		die("conflicting modes: .perms=%#o, filesystem=%#o", p->mode, st.st_mode);
	if (chmod_v(p->name, p->mode & ~S_IFMT) < 0)
		die("chmod:");
applied:
	p->applied = true;
}

static void
specialperms(void)
{
	int i = oldsp.len - 1, j = newsp.len - 1, n;

	/* process in reverse order so that directory removals can succeed */
	while (i >= 0 || j >= 0) {
		if (i < 0)
			n = 1;
		else if (j < 0)
			n = -1;
		else
			n = strcmp(oldsp.perms[i].name, newsp.perms[j].name);
		if (n >= 0) {
			if (!newsp.perms[j].applied)
				specialperm(&newsp.perms[j]);
			--j;
			if (n == 0)
				--i;
			continue;
		}
		switch (oldsp.perms[i].mode&S_IFMT) {
		case S_IFDIR:
			if (rmdir(oldsp.perms[i].name) < 0) switch (errno) {
				case ENOENT:
				case ENOTEMPTY:
					break;
				default:
					die("rmdir:");
			}
			break;
		default:
			if (defperm(oldsp.perms[i].name) < 0) switch (errno) {
				case ENOENT:
				case EXDEV:
					break;
				default:
					die("defperm:");
			}
		}
		--i;
	}
}

static int
setperm(const char *name)
{
	int i;

	for (i = 0; i < newsp.len; ++i) {
		if (strcmp(name, newsp.perms[i].name) == 0) {
			if (!newsp.perms[i].applied)
				specialperm(&newsp.perms[i]);
			return 0;
		}
	}
	return defperm(name);
}

static void
readchanges(char *old, char *new)
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
	char *path, *diff, *s;

	f = spawn(old ? argv_diff : argv_new, &pid);
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
			die("setperm %s:", path);
		}
		/* find the first difference from the previous path */
		diff = path;
		if (lines[!cur].buf)
			for (s = lines[!cur].buf; *s && *s == *diff; ++s, ++diff);
		/* set permissions on each parent directory after that difference */
		for (s = path + n; s > diff; --s) {
			if (*s != '/')
				continue;
			*s = '\0';
			if (setperm(path) < 0)
				die("setperm %s:", path);
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

int main(int argc, char *argv[]) {
	char *old, *new;
	struct stat st;

	switch (argc) {
	case 1:
		old = NULL;
		new = "HEAD";
		break;
	case 2:
		old = NULL;
		new = argv[1];
		break;
	case 3:
		old = argv[1];
		new = argv[2];
		break;
	default:
		fprintf(stderr, "usage: %s [[old] new]\n", basename(argv[0]));
		exit(2);
	}

	if (stat(".", &st) < 0)
		die("stat:");
	rootdev = st.st_dev;

	if (old)
		readspecial(&oldsp, old);
	readspecial(&newsp, new);
	umask(0);
	readchanges(old, new);

	return 0;
}
