#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static const char safe[] =
	"][ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#%&'()*+,./:;<=>^_{|}~ -";

int main(int argc, char *argv[]) {
	FILE *f;
	char *line = NULL, *s;
	size_t size = 0;
	ssize_t n;

	f = fopen(argv[1], "r");
	if (!f) {
		fprintf(stderr, "fopen %s: %s\n", argv[1], strerror(errno));
		return 1;
	}

	printf("/* Generated from %s */\n", argv[1]);
	while ((n = getline(&line, &size, f)) >= 0) {
		printf("\"");
		for (s = line; s < line + n; ++s) {
			if (memchr(safe, *s, sizeof(safe) - 1))
				fputc(*s, stdout);
			else
				printf("\\%03hho", *s);
		}
		printf("\"\n");
	}
	if (ferror(f)) {
		fprintf(stderr, "ferror: %s\n", strerror(errno));
		return 1;
	}

	return 0;
}
