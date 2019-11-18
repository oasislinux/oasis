#define _POSIX_C_SOURCE 200809L
#include <errno.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdnoreturn.h>
#include <string.h>
#include <sys/stat.h>

struct perm {
	char *name;
	mode_t mode;
};

static struct perm *perms;
static size_t permslen, permscap;

static noreturn void
fatal(const char *fmt, ...)
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
	exit(1);
}

static void
addperm(struct perm *p)
{
	if (permslen == permscap) {
		permscap = permscap ? permscap * 2 : 64;
		if (permscap > SIZE_MAX / sizeof(perms[0])) {
			errno = ENOMEM;
			fatal("realloc:");
		}
		perms = realloc(perms, permscap * sizeof(perms[0]));
		if (!perms)
			fatal("realloc:");
	}
	perms[permslen++] = *p;
}

static void
readperm(FILE *file, struct perm *perm)
{
	static char *line;
	static size_t size;
	ssize_t n;
	char *s, *mode;

	n = getline(&line, &size, file);
	if (n < 0) {
		if (ferror(file))
			fatal("getline:");
		perm->name = NULL;
		return;
	}
	if (n && line[n - 1] == '\n')
		line[n - 1] = '\0';
	mode = s = line;
	s = strchr(s, ' ');
	if (!s || s == mode)
		fatal("invalid permissions file");
	*s++ = '\0';
	perm->name = strdup(s);
	if (!perm->name)
		fatal("strdup:");
	perm->mode = strtoul(mode, &s, 8);
	if (*s)
		fatal("invalid mode '%s'", mode);
}

static int
permcmp(struct perm *a, struct perm *b)
{
	return a->name ? b->name ? strcmp(a->name, b->name) : -1 : !!b->name;
}

static noreturn void
usage(void)
{
	fprintf(stderr, "usage: mergeperms old cur new\n");
	exit(2);
}

int
main(int argc, char *argv[])
{
	FILE *oldf, *curf, *newf;
	struct perm old, cur, new;
	int ij, ik, jk;
	int ret;

	if (argc != 4)
		usage();

	ret = 0;
	oldf = fopen(argv[1], "r");
	if (!oldf)
		fatal("open %s:", argv[1]);
	curf = fopen(argv[2], "r");
	if (!curf)
		fatal("open %s:", argv[2]);
	newf = fopen(argv[3], "r");
	if (!newf)
		fatal("open %s:", argv[3]);

	readperm(oldf, &old);
	readperm(curf, &cur);
	readperm(newf, &new);
	for (;;) {
		ij = permcmp(&old, &cur);
		ik = permcmp(&old, &new);
		if (ij < 0 && ik < 0 && old.name) {
			readperm(oldf, &old);
			continue;
		}
		if (!old.name && !cur.name && !new.name)
			break;
		jk = permcmp(&cur, &new);
		if ((jk < 0 && ij == 0 && old.mode == cur.mode) || (jk > 0 && ik == 0 && old.mode == new.mode)) {
			/* deleted in cur or new and unchanged in the other */
		} else if (jk < 0) {
			if (ij == 0)
				ret = 3;
			addperm(&cur);
		} else if (jk > 0) {
			if (ik == 0)
				ret = 3;
			addperm(&new);
		} else if (ij == 0 && old.mode == cur.mode) {
			addperm(&new);
		} else {
			if (cur.mode != new.mode && (ik != 0 || old.mode != new.mode))
				ret = 3;
			addperm(&cur);
		}
		if (jk <= 0)
			readperm(curf, &cur);
		if (jk >= 0)
			readperm(newf, &new);
	}

	fclose(curf);
	curf = fopen(argv[2], "w");
	if (!curf)
		fatal("open %s:", argv[1]);
	for (; permslen > 0; --permslen, ++perms)
		fprintf(curf, "%#o %s\n", perms->mode, perms->name);
	fflush(curf);
	if (ferror(curf))
		fatal("write error");

	return ret;
}
