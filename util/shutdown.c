/* See LICENSE file for copyright and license details. */
#define _XOPEN_SOURCE 700
#include <errno.h>
#include <mntent.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdnoreturn.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/reboot.h>
#include <unistd.h>

static noreturn void
usage()
{
	fprintf(stderr, "usage: shutdown [-hpr]\n");
	exit(2);
}

int
main(int argc, char *argv[])
{
	FILE *fp;
	char **dirs = NULL;
	size_t n = 0;
	struct mntent *mnt;
	int cmd = RB_POWER_OFF;

	while (*++argv && (*argv)[0] == '-' && (*argv)[1]) {
		switch ((*argv)[1]) {
		case 'h':
			cmd = RB_HALT_SYSTEM;
			break;
		case 'p':
			cmd = RB_POWER_OFF;
			break;
		case 'r':
			cmd = RB_AUTOBOOT;
			break;
		default:
			usage();
		}
	}
	if (*argv)
		usage();

	if (getsid(0) != getpid()) {
		fprintf(stderr, "must be session leader\n");
		return 1;
	}

	sync();
	kill(-1, SIGTERM);
	sleep(2);
	kill(-1, SIGKILL);

	sync();
	fp = setmntent("/proc/mounts", "r");
	if (!fp) {
		perror("setmntent");
		goto reboot;
	}
	while ((mnt = getmntent(fp))) {
		if (!(dirs = realloc(dirs, ++n * sizeof(*dirs)))) {
			perror("realloc");
			break;
		}
		if (!(dirs[n - 1] = strdup(mnt->mnt_dir))) {
			perror("strdup");
			break;
		}
	}
	endmntent(fp);
	while (n) {
		if (umount(dirs[--n]) < 0)
			fprintf(stderr, "umount %s: %s\n", dirs[n], strerror(errno));
		free(dirs[n]);
	}
	free(dirs);

reboot:
	if (reboot(cmd) < 0) {
		perror("reboot");
		return 1;
	}
}
