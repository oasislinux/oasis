#include <err.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>

void
usage(void)
{
	errx(2, "usage: bin2c tablename [align]");
}

int
main(int argc, char *argv[])
{
	char buf[4096], *s, *table_name;
	ssize_t n;
	size_t total = 0, pad, align = 0;
	struct stat st;

	switch (argc) {
	case 3:
		align = strtoul(argv[2], &s, 10);
		if (*s)
			usage();
	case 2:
		table_name = argv[1];
		break;
	default:
		usage();
	}

	if (fstat(0, &st) < 0)
		err(1, "fstat 0");

	printf("unsigned char %s[] = {", table_name);

	for (;;) {
		n = read(0, buf, sizeof(buf));
		if (n < 0)
			err(1, "read");
		if (n == 0)
			break;
		for (s = buf; s < buf + n; ++s) {
			if (total++ % 8 == 0)
				printf("\n\t");
			printf("0x%02hhx,", *s);
		}
	}
	if (align) {
		for (pad = (total + (align - 1)) / align * align - total; pad; --pad) {
			if (total++ % 8 == 0)
				printf("\n\t");
			printf("0x00,");
		}
	}

	printf("\n};\n\nconst unsigned int %s_len = %zu;\n", table_name, total);
	printf("\nconst int %s_mtime = %ld;\n", table_name, st.st_mtime);

	return 0;
}
