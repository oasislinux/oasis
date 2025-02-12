#define PACKAGE "luaposix"
#define VERSION "v36.2.1"

/* fcntl */
#define HAVE_POSIX_FADVISE 1

/* sched */
#define HAVE_SCHED_H 1
#define HAVE_SCHED_GETSCHEDULER 1
#define HAVE_SCHED_SETSCHEDULER 1

/* sys.msg */
#define HAVE_SYS_MSG_H 1
#define HAVE_MSGRCV 1
#define HAVE_MSGSND 1

/* sys.socket */
#define HAVE_NET_IF_H 1
#define HAVE_LINUX_NETLINK_H 1
#define HAVE_LINUX_IF_PACKET_H 1

/* sys.statvfs */
#define HAVE_STATVFS 1

/* time */
#define HAVE_TM_GMTOFF 1
#define HAVE_TM_ZONE 1

/* unistd */
#define HAVE_CRYPT 1
#define HAVE_CRYPT_H 1
#define HAVE_DECL_FDATASYNC 1
#define HAVE_FDATASYNC 1
#define HAVE_GETHOSTID 1
