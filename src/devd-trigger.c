#define _XOPEN_SOURCE 700
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdnoreturn.h>
#include <string.h>

#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>

static char path[PATH_MAX] = "/sys/devices";
static size_t pathlen;
static int ret;

static void
error(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	if (fmt[0] && fmt[strlen(fmt) - 1] == ':') {
		fputc(' ', stderr);
		perror(NULL);
	} else {
		fputc('\n', stderr);
	}
	ret = 1;
}

static void
trigger(int fd, const char *name)
{
	static const char action[] = "add";

	fd = openat(fd, name, O_WRONLY);
	if (fd == -1) {
		error("open %s:", path);
	} else {
		if (write(fd, action, sizeof(action) - 1) != (ssize_t)(sizeof(action) - 1))
			error("write %s:", path);
		close(fd);
	}
}

static void
search(int fd, const char *name)
{
	DIR *dir;
	struct dirent *d;
	char *nul;
	size_t oldlen;
	struct stat st;

	fd = openat(fd, name, O_RDONLY | O_DIRECTORY);
	if (fd == -1) {
		error("opendir %s:", path);
		return;
	}
	dir = fdopendir(fd);
	if (!dir) {
		error("opendir %s:", path);
		return;
	}
	oldlen = pathlen;
	for (;; pathlen = oldlen) {
		errno = 0;
		d = readdir(dir);
		if (!d)
			break;
		if (strcmp(d->d_name, ".") == 0 || strcmp(d->d_name, "..") == 0)
			continue;
		path[pathlen++] = '/';
		nul = memccpy(path + pathlen, d->d_name, '\0', sizeof(path) - pathlen);
		if (!nul) {
			error("path too large");
			continue;
		}
		pathlen = nul - path - 1;
		if (fstatat(fd, d->d_name, &st, AT_SYMLINK_NOFOLLOW) == -1) {
			error("stat %s:", path);
			continue;
		}
		if (S_ISDIR(st.st_mode))
			search(fd, d->d_name);
		else if (S_ISREG(st.st_mode) && strcmp(d->d_name, "uevent") == 0)
			trigger(fd, d->d_name);
	}
	path[pathlen] = '\0';
	if (errno)
		error("readdir %s", path);
	closedir(dir);
}

int
main(int argc, char *argv[])
{
	pathlen = strlen(path);
	search(AT_FDCWD, path);
	return ret;
}
