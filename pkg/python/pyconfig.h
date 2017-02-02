#include <config-posix.h>

#ifndef Py_PYCONFIG_H
#define Py_PYCONFIG_H
/* #undef AC_APPLE_UNIVERSAL_BUILD */
/* #undef AIX_GENUINE_CPLUSPLUS */
/* #undef DOUBLE_IS_ARM_MIXED_ENDIAN_IEEE754 */
/* #undef DOUBLE_IS_BIG_ENDIAN_IEEE754 */
#define DOUBLE_IS_LITTLE_ENDIAN_IEEE754 1
#define ENABLE_IPV6 1
/* #undef FLOCK_NEEDS_LIBBSD */
/* #undef GETPGRP_HAVE_ARG */
/* #undef GETTIMEOFDAY_NO_TZ */
#define HAVE_ACCEPT4 1
#define HAVE_ADDRINFO 1
/* #undef HAVE_ALIGNED_REQUIRED */
#define HAVE_ALLOCA_H 1
/* #undef HAVE_ALTZONE */
#define HAVE_ASM_TYPES_H 1
#define HAVE_BIND_TEXTDOMAIN_CODESET 1
/* #undef HAVE_BLUETOOTH_BLUETOOTH_H */
/* #undef HAVE_BLUETOOTH_H */
/* #undef HAVE_BROKEN_MBSTOWCS */
#define HAVE_BROKEN_NICE 1
/* #undef HAVE_BROKEN_PIPE_BUF */
/* #undef HAVE_BROKEN_POLL */
/* #undef HAVE_BROKEN_POSIX_SEMAPHORES */
/* #undef HAVE_BROKEN_PTHREAD_SIGMASK */
/* #undef HAVE_BROKEN_SEM_GETVALUE */
/* #undef HAVE_BROKEN_UNSETENV */
#define HAVE_BUILTIN_ATOMIC 1
#define HAVE_C99_BOOL 1
/* #undef HAVE_CHFLAGS */
#define HAVE_CHROOT 1
#define HAVE_COMPUTED_GOTOS 1
/* #undef HAVE_CONIO_H */
/* #undef HAVE_CTERMID_R */
/* #undef HAVE_CURSES_H */
/* #undef HAVE_CURSES_IS_TERM_RESIZED */
/* #undef HAVE_CURSES_RESIZETERM */
/* #undef HAVE_CURSES_RESIZE_TERM */
#define HAVE_DECL_ISFINITE 1
#define HAVE_DECL_ISINF 1
#define HAVE_DECL_ISNAN 1
/* #undef HAVE_DECL_TZNAME */
#define HAVE_DEVICE_MACROS 1
/* #undef HAVE_DEV_PTC */
#define HAVE_DEV_PTMX 1
/* #undef HAVE_DIRECT_H */
#define HAVE_DIRENT_D_TYPE 1
#define HAVE_DUP3 1
/* #undef HAVE_DYNAMIC_LOADING */
#define HAVE_ENDIAN_H 1
#define HAVE_EPOLL 1
#define HAVE_EPOLL_CREATE1 1
#define HAVE_FINITE 1
#define HAVE_FLOCK 1
#define HAVE_FORKPTY 1
/* #undef HAVE_FSEEK64 */
/* #undef HAVE_FTELL64 */
#define HAVE_FTIME 1
#define HAVE_FUTIMES 1
#define HAVE_FUTIMESAT 1
/* #undef HAVE_GAMMA */
/* #undef HAVE_GCC_ASM_FOR_MC68881 */
#define HAVE_GCC_ASM_FOR_X64 1
#define HAVE_GCC_ASM_FOR_X87 1
#define HAVE_GCC_UINT128_T 1
/* #undef HAVE_GETENTROPY */
#define HAVE_GETGROUPLIST 1
/* #undef HAVE_GETHOSTBYNAME */
#define HAVE_GETHOSTBYNAME_R 1
/* #undef HAVE_GETHOSTBYNAME_R_3_ARG */
/* #undef HAVE_GETHOSTBYNAME_R_5_ARG */
#define HAVE_GETHOSTBYNAME_R_6_ARG 1
#define HAVE_GETLOADAVG 1
#define HAVE_GETPAGESIZE 1
/* #undef HAVE_GETRANDOM */
#define HAVE_GETRANDOM_SYSCALL 1
#define HAVE_GETRESGID 1
#define HAVE_GETRESUID 1
#define HAVE_GETSPENT 1
#define HAVE_GETSPNAM 1
/* #undef HAVE_GETWD */
/* #undef HAVE_GLIBC_MEMMOVE_BUG */
#define HAVE_HSTRERROR 1
#define HAVE_HTOLE64 1
/* #undef HAVE_IEEEFP_H */
#define HAVE_INET_ATON 1
#define HAVE_INITGROUPS 1
#define HAVE_INT32_T 1
#define HAVE_INT64_T 1
/* #undef HAVE_IO_H */
/* #undef HAVE_IPA_PURE_CONST_BUG */
/* #undef HAVE_KQUEUE */
/* #undef HAVE_LARGEFILE_SUPPORT */
/* #undef HAVE_LCHFLAGS */
#define HAVE_LCHMOD 1
#define HAVE_LIBDL 1
/* #undef HAVE_LIBDLD */
/* #undef HAVE_LIBIEEE */
#define HAVE_LIBINTL_H 1
/* #undef HAVE_LIBREADLINE */
/* #undef HAVE_LIBRESOLV */
/* #undef HAVE_LIBSENDFILE */
/* #undef HAVE_LIBUTIL_H */
#define HAVE_LINUX_CAN_BCM_H 1
#define HAVE_LINUX_CAN_H 1
#define HAVE_LINUX_CAN_RAW_FD_FRAMES 1
#define HAVE_LINUX_CAN_RAW_H 1
#define HAVE_LINUX_NETLINK_H 1
#define HAVE_LINUX_RANDOM_H 1
#define HAVE_LINUX_TIPC_H 1
#define HAVE_LONG_DOUBLE 1
#define HAVE_LONG_LONG 1
#define HAVE_LUTIMES 1
#define HAVE_MAKEDEV 1
#define HAVE_MEMORY_H 1
#define HAVE_MEMRCHR 1
#define HAVE_MREMAP 1
/* #undef HAVE_NCURSES_H */
/* #undef HAVE_NDIR_H */
#define HAVE_NETPACKET_PACKET_H 1
#define HAVE_OPENPTY 1
/* #undef HAVE_OSX105_SDK */
#define HAVE_PIPE2 1
/* #undef HAVE_PLOCK */
#define HAVE_PRLIMIT 1
/* #undef HAVE_PROCESS_H */
#define HAVE_PROTOTYPES 1
/* #undef HAVE_PTHREAD_DESTRUCTOR */
/* #undef HAVE_PTHREAD_INIT */
#define HAVE_PTY_H 1
/* #undef HAVE_RL_APPEND_HISTORY */
/* #undef HAVE_RL_CALLBACK */
/* #undef HAVE_RL_CATCH_SIGNAL */
/* #undef HAVE_RL_COMPLETION_APPEND_CHARACTER */
/* #undef HAVE_RL_COMPLETION_DISPLAY_MATCHES_HOOK */
/* #undef HAVE_RL_COMPLETION_MATCHES */
/* #undef HAVE_RL_COMPLETION_SUPPRESS_APPEND */
/* #undef HAVE_RL_PRE_INPUT_HOOK */
/* #undef HAVE_RL_RESIZE_TERMINAL */
#define HAVE_SCHED_SETAFFINITY 1
#define HAVE_SENDFILE 1
#define HAVE_SETGROUPS 1
#define HAVE_SETHOSTNAME 1
#define HAVE_SETRESGID 1
#define HAVE_SETRESUID 1
#define HAVE_SHADOW_H 1
/* #undef HAVE_SOCKADDR_SA_LEN */
#define HAVE_SOCKADDR_STORAGE 1
#define HAVE_STAT_TV_NSEC 1
/* #undef HAVE_STAT_TV_NSEC2 */
#define HAVE_STDARG_PROTOTYPES 1
#define HAVE_STD_ATOMIC 1
#define HAVE_STRLCPY 1
/* #undef HAVE_STRUCT_STAT_ST_BIRTHTIME */
#define HAVE_STRUCT_STAT_ST_BLKSIZE 1
#define HAVE_STRUCT_STAT_ST_BLOCKS 1
/* #undef HAVE_STRUCT_STAT_ST_FLAGS */
/* #undef HAVE_STRUCT_STAT_ST_GEN */
#define HAVE_STRUCT_TM_TM_ZONE 1
#define HAVE_SYSEXITS_H 1
/* #undef HAVE_SYS_AUDIOIO_H */
/* #undef HAVE_SYS_BSDTTY_H */
/* #undef HAVE_SYS_DEVPOLL_H */
/* #undef HAVE_SYS_DIR_H */
/* #undef HAVE_SYS_ENDIAN_H */
#define HAVE_SYS_EPOLL_H 1
/* #undef HAVE_SYS_EVENT_H */
#define HAVE_SYS_FILE_H 1
#define HAVE_SYS_IOCTL_H 1
/* #undef HAVE_SYS_KERN_CONTROL_H */
/* #undef HAVE_SYS_LOADAVG_H */
/* #undef HAVE_SYS_LOCK_H */
/* #undef HAVE_SYS_MKDEV_H */
/* #undef HAVE_SYS_MODEM_H */
/* #undef HAVE_SYS_NDIR_H */
#define HAVE_SYS_PARAM_H 1
#define HAVE_SYS_POLL_H 1
/* #undef HAVE_SYS_RANDOM_H */
#define HAVE_SYS_SENDFILE_H 1
#define HAVE_SYS_SYSCALL_H 1
/* #undef HAVE_SYS_SYS_DOMAIN_H */
/* #undef HAVE_SYS_TERMIO_H */
#define HAVE_SYS_XATTR_H 1
/* #undef HAVE_TERM_H */
#define HAVE_TIMEGM 1
/* #undef HAVE_TMPNAM_R */
#define HAVE_TM_ZONE 1
/* #undef HAVE_UCS4_TCL */
#define HAVE_UINT32_T 1
#define HAVE_UINT64_T 1
/* #undef HAVE_USABLE_WCHAR_T */
/* #undef HAVE_UTIL_H */
#define HAVE_WAIT3 1
#define HAVE_WAIT4 1
#define HAVE_WORKING_TZSET 1
#define HAVE_ZLIB_COPY 1
/* #undef HAVE__GETPTY */
/* #undef LOG1P_DROPS_ZERO_SIGN */
/* #undef MAJOR_IN_MKDEV */
/* #undef MAJOR_IN_SYSMACROS */
/* #undef MVWDELCH_IS_EXPRESSION */
/* #undef PACKAGE_BUGREPORT */
/* #undef PACKAGE_NAME */
/* #undef PACKAGE_STRING */
/* #undef PACKAGE_TARNAME */
/* #undef PACKAGE_URL */
/* #undef PACKAGE_VERSION */
/* #undef POSIX_SEMAPHORES_NOT_ENABLED */
#define PTHREAD_SYSTEM_SCHED_SUPPORTED 1
/* #undef PYLONG_BITS_IN_DIGIT */
#define PY_FORMAT_LONG_LONG "ll"
#define PY_FORMAT_SIZE_T "z"
/* #undef Py_DEBUG */
/* #undef Py_ENABLE_SHARED */
/* #undef Py_HASH_ALGORITHM */
/* #undef SETPGRP_HAVE_ARG */
/* #undef SIGNED_RIGHT_SHIFT_ZERO_FILLS */
#define SIZEOF_DOUBLE 8
#define SIZEOF_FLOAT 4
#define SIZEOF_FPOS_T 16
#define SIZEOF_INT 4
#define SIZEOF_LONG 8
#define SIZEOF_LONG_DOUBLE 16
#define SIZEOF_LONG_LONG 8
#define SIZEOF_OFF_T 8
#define SIZEOF_PID_T 4
#define SIZEOF_PTHREAD_T 8
#define SIZEOF_SHORT 2
#define SIZEOF_SIZE_T 8
#define SIZEOF_TIME_T 8
#define SIZEOF_UINTPTR_T 8
#define SIZEOF_VOID_P 8
#define SIZEOF_WCHAR_T 4
#define SIZEOF__BOOL 1
#define SYS_SELECT_WITH_SYS_TIME 1
#define TANH_PRESERVES_ZERO_SIGN 1
/* #undef TIMEMODULE_LIB */
#define TIME_WITH_SYS_TIME 1
/* #undef TM_IN_SYS_TIME */
/* #undef USE_COMPUTED_GOTOS */
#define USE_INLINE 1
#ifndef _ALL_SOURCE
# define _ALL_SOURCE 1
#endif
#ifndef _GNU_SOURCE
# define _GNU_SOURCE 1
#endif
#ifndef _POSIX_PTHREAD_SEMANTICS
# define _POSIX_PTHREAD_SEMANTICS 1
#endif
#ifndef _TANDEM_SOURCE
# define _TANDEM_SOURCE 1
#endif
#ifndef __EXTENSIONS__
# define __EXTENSIONS__ 1
#endif
#define VA_LIST_IS_ARRAY 1
/* #undef WANT_SIGFPE_HANDLER */
/* #undef WINDOW_HAS_FLAGS */
#define WITH_DOC_STRINGS 1
/* #undef WITH_DYLD */
/* #undef WITH_LIBINTL */
/* #undef WITH_NEXT_FRAMEWORK */
#define WITH_PYMALLOC 1
#define WITH_THREAD 1
/* #undef WITH_TSC */
/* #undef WITH_VALGRIND */
#if defined AC_APPLE_UNIVERSAL_BUILD
# if defined __BIG_ENDIAN__
#  define WORDS_BIGENDIAN 1
# endif
#else
# ifndef WORDS_BIGENDIAN
/* #  undef WORDS_BIGENDIAN */
# endif
#endif
/* #undef X87_DOUBLE_ROUNDING */
/* #undef _BSD_SOURCE */
#define _BSD_TYPES 1
#define _DARWIN_C_SOURCE 1
#define _FILE_OFFSET_BITS 64
#define _GNU_SOURCE 1
/* #undef _INCLUDE__STDC_A1_SOURCE */
#define _LARGEFILE_SOURCE 1
/* #undef _LARGE_FILES */
/* #undef _MINIX */
#define _NETBSD_SOURCE 1
/* #undef _POSIX_1_SOURCE */
#define _POSIX_C_SOURCE 200809L
/* #undef _POSIX_SOURCE */
/* #undef _POSIX_THREADS */
#define _REENTRANT 1
   #define below would cause a syntax error. */
/* #undef _UINT32_T */
   #define below would cause a syntax error. */
/* #undef _UINT64_T */
#define _XOPEN_SOURCE 700
#define _XOPEN_SOURCE_EXTENDED 1
#define __BSD_VISIBLE 1
#ifndef __CHAR_UNSIGNED__
/* # undef __CHAR_UNSIGNED__ */
#endif
/* #undef clock_t */
/* #undef const */
/* #undef gid_t */
#ifndef __cplusplus
/* #undef inline */
#endif
/* #undef int32_t */
/* #undef int64_t */
/* #undef mode_t */
/* #undef off_t */
/* #undef pid_t */
/* #undef signed */
/* #undef size_t */
/* #undef socklen_t */
/* #undef uid_t */
/* #undef uint32_t */
/* #undef uint64_t */
/* #undef volatile */
#if defined(__USLC__) && defined(__SCO_VERSION__)
#define STRICT_SYSV_CURSES /* Don't use ncurses extensions */
#endif
#endif /*Py_PYCONFIG_H*/
