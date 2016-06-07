/* 
See LICENSE file for copyright and license details.
 
This program is a git hook to fix the permissions of files based on a .perms
file in the repository

TODO: We should read the old .perms file, and remove any directories listed
there that are not present in the new .perms file.

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

struct perm {
	mode_t mode;
	char *name;
	bool fixed;
};

extern char **environ;

static char *argv0;
static dev_t rootdev;
static struct perm *perms;
static int perms_len;

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
readperms(void)
{
	static char *argv[] = { "git", "show", ":.perms", 0 };
	FILE *f;
	pid_t pid;
	char *line = NULL, *s, *mode;
	size_t size = 0;
	ssize_t n;
	int st;

	f = spawn(argv, &pid);
	while ((n = getline(&line, &size, f)) >= 0) {
		if (line[n-1] == '\n')
			line[--n] = '\0';
		mode = s = line;
		s = strchr(s, ' ');
		if (!s || s == mode)
			die("malformed .perms file");
		*s++ = '\0';
		perms = realloc(perms, (perms_len + 1) * sizeof(*perms));
		if (!perms)
			die("realloc:");
		perms[perms_len].name = strdup(s);
		if (!perms[perms_len].name)
			die("strdup:");
		perms[perms_len].mode = strtoul(mode, &s, 8);
		perms[perms_len].fixed = false;
		if (*s)
			die("invalid mode: %s\n", mode);
		++perms_len;
	}
	fclose(f);

	if (waitpid(pid, &st, 0) < 0)
		die("waitpid:");
	if (!(WIFEXITED(st) && WEXITSTATUS(st) == 0))
		die("child process failed");
}

static void
fixperm(struct perm *p)
{
	struct stat st;

	if (lstat(p->name, &st) < 0) {
		if (errno != ENOENT)
			die("lstat:");
		if (!S_ISDIR(p->mode))
			die("file missing and not a directory: %s", p->name);
		if (mkdir(p->name, p->mode & ~S_IFMT) < 0)
			die("mkdir:");
		return;
	}
	if (st.st_dev != rootdev || st.st_mode == p->mode)
		return;
	if ((st.st_mode&S_IFMT) != (p->mode&S_IFMT))
		die("conflicting modes: .perms=%#o, filesystem=%#o", p->mode, st.st_mode);
	if (chmod(p->name, p->mode & ~S_IFMT) < 0)
		die("chmod:");
}

static void
fixperms(void)
{
	int i;

	for (i = 0; i < perms_len; ++i) {
		if (!perms[i].fixed)
			fixperm(&perms[i]);
	}
}

static void
defperm(const char *name)
{
	struct stat st;
	mode_t mode;

	if (lstat(name, &st) < 0)
		die("lstat:");
	if (st.st_dev != rootdev)
		return;
	switch (st.st_mode & S_IFMT) {
	case S_IFREG:
		mode = st.st_mode&S_IXUSR ? 0755 : 0644;
		if ((st.st_mode&~S_IFMT) == mode)
			return;
		if (chmod(name, mode) < 0)
			die("chmod:");
		break;
	case S_IFLNK:
		return;
	default:
		die("unexpected file type %#o: %s", st.st_mode, name);
	}
}

static void
readchanges(char *old, char *new)
{
	char *argv_diff[] = { "git", "diff", "--name-only", "-z", old, new, 0 };
	char *argv_new[] = { "git", "ls-tree", "--name-only", "--full-tree", "-z", "-r", new, 0 };
	FILE *f;
	pid_t pid;
	char *line = NULL;
	size_t size = 0;
	int i, st;

	f = spawn(old ? argv_diff : argv_new, &pid);
nextline:
	while (getdelim(&line, &size, '\0', f) >= 0) {
		if (strcmp(line, ".perms") == 0) {
			fixperms();
			continue;
		}
		for (i = 0; i < perms_len; ++i) {
			if (!perms[i].fixed && strcmp(line, perms[i].name) == 0) {
				fixperm(&perms[i]);
				goto nextline;
			}
		}
		defperm(line);
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

	argv0 = basename(argv[0]);
	if (strcmp(argv0, "post-merge") == 0) {
		if (argc != 2) {
			fprintf(stderr, "usage: %s flag\n", argv0);
			exit(2);
		}
		old = "ORIG_HEAD";
		new = "HEAD";
	} else if (strcmp(argv0, "post-checkout") == 0) {
		if (argc != 4) {
			fprintf(stderr, "usage: %s old new flag\n", argv0);
			exit(2);
		}
		old = argv[1];
		new = argv[2];
	} else if (argc == 1) {
		old = NULL;
		new = "HEAD";
	} else {
		fprintf(stderr, "usage: %s\n", argv0);
		exit(2);
	}

	if (stat(".", &st) < 0)
		die("stat:");
	rootdev = st.st_dev;	

	readperms();
	readchanges(old, new);

	return 0;
}
