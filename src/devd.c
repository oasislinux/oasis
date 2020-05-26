/*
devd reads kernel uevents via netlink and for each one spawns the
/etc/hotplug script with an environment consisting of the uevent
keys and values.

After setting up the netlink socket, devd does a double fork to
execute an orphaned /libexec/devd-trigger, which walks /sys/devices,
triggering "add" uevents for each one.
*/
#define _POSIX_C_SOURCE 200809L
#include <errno.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdnoreturn.h>
#include <string.h>

#include <fcntl.h>
#include <spawn.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <unistd.h>

#include <linux/netlink.h>

#ifndef PREFIX
#define PREFIX
#endif
#define HOTPLUG PREFIX "/etc/hotplug"
#define TRIGGER PREFIX "/libexec/devd-trigger"

#define LEN(a) (sizeof(a) / sizeof((a)[0]))

static posix_spawn_file_actions_t fileactions;

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

static int
spawn(char *cmd, char *const env[])
{
	int err, status;
	pid_t pid;

	err = posix_spawn(&pid, cmd, &fileactions, NULL, (char *[]){cmd, NULL}, env);
	if (err) {
		fprintf(stderr, "spawn %s: %s\n", cmd, strerror(err));
		return -1;
	}
	if (waitpid(pid, &status, 0) == -1) {
		fprintf(stderr, "wait %jd: %s\n", (intmax_t)pid, strerror(errno));
		return -1;
	}
	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
		return -1;
	return 0;
}

int
main(int argc, char *argv[])
{
	extern char **environ;
	int sock, err, status, rcvbuf = 8 * 1024 * 1024;
	struct sockaddr_nl addr = {
		.nl_family = AF_NETLINK,
		.nl_groups = 1,
	};
	char buf[8192], *var, *eql, *nul, **envp, *env[256];
	size_t envlen, envbase;
	struct msghdr msg = {
		.msg_iov = (struct iovec[]){{buf, sizeof(buf)}},
		.msg_iovlen = 1,
	};
	ssize_t ret;
	pid_t pid;

	/* setup environment */
	envlen = 0;
	for (envp = environ; *envp; ++envp) {
		if (strncmp(*envp, "PATH=", 5) == 0 ||
		    strncmp(*envp, "HOME=", 5) == 0)
		{
			env[envlen++] = *envp;
		}
	}
	envbase = envlen;

	/* create spawn file actions for child */
	err = posix_spawn_file_actions_init(&fileactions);
	if (err) {
		perror(NULL);
		return 1;
	}
	err = posix_spawn_file_actions_addopen(&fileactions, 0, "/dev/null", O_RDONLY, 0);
	if (err) {
		perror(NULL);
		return 1;
	}

	/* open netlink socket */
	sock = socket(AF_NETLINK, SOCK_DGRAM | SOCK_CLOEXEC, NETLINK_KOBJECT_UEVENT);
	if (sock == -1)
		fatal("socket:");
	if (setsockopt(sock, SOL_SOCKET, SO_RCVBUFFORCE, &rcvbuf, sizeof(rcvbuf)) == -1)
		fatal("setsockopt:");
	if (bind(sock, (struct sockaddr *)&addr, sizeof(addr)) == -1)
		fatal("bind:");

	/* trigger system uevents */
	pid = fork();
	if (pid == -1)
		fatal("fork:");
	if (pid == 0) {
		err = posix_spawn(&pid, TRIGGER, NULL, NULL, (char *[]){TRIGGER, NULL}, environ);
		if (err)
			fatal("spawn %s:", TRIGGER);
		return 0;
	}
	if (waitpid(pid, &status, 0) == -1)
		fatal("waitpid %jd:", (intmax_t)pid);
	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
		return 1;

next:
	for (;;) {
		ret = recvmsg(sock, &msg, sizeof(buf));
		if (ret == 0)
			break;
		if (ret == -1)
			fatal("recvmsg:");
		if (msg.msg_flags & MSG_TRUNC)
			continue;
		envlen = envbase;
		for (var = buf; var < buf + ret; var = nul + 1) {
			nul = memchr(var, '\0', ret - (var - buf));
			if (!nul) {
				fprintf(stderr, "netlink message is not NULL-terminated\n");
				goto next;
			}
			eql = strchr(var, '=');
			if (!eql)
				continue;
			if (envlen == LEN(env) - 1) {
				fprintf(stderr, "uevent has too many variables\n");
				goto next;
			}
			env[envlen++] = var;
		}
		env[envlen] = NULL;
		spawn(HOTPLUG, env);
	}
}
