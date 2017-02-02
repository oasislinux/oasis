/* don't use config-posix.h here, this file gets processed by make-event-config.sed */

/* disabled to prevent building extra backends */
/* #undef HAVE_POLL */
/* #undef HAVE_SELECT */

#define DISABLE_DEBUG_MODE 1
#define DISABLE_MM_REPLACEMENT 1
/* #undef DISABLE_THREAD_SUPPORT */
/* #undef HAVE_ARC4RANDOM */
/* #undef HAVE_ARC4RANDOM_BUF */
#define HAVE_ARPA_INET_H 1
#define HAVE_CLOCK_GETTIME 1
/* #undef HAVE_DECL_CTL_KERN */
/* #undef HAVE_DECL_KERN_ARND */
/* #undef HAVE_DECL_KERN_RANDOM */
/* #undef HAVE_DECL_RANDOM_UUID */
/* #undef HAVE_DEVPOLL */
#define HAVE_DLFCN_H 1
#define HAVE_EPOLL 1
#define HAVE_EPOLL_CTL 1
#define HAVE_EVENTFD 1
/* #undef HAVE_EVENT_PORTS */
#define HAVE_FCNTL 1
#define HAVE_FCNTL_H 1
#define HAVE_FD_MASK 1
#define HAVE_GETADDRINFO 1
#define HAVE_GETEGID 1
#define HAVE_GETEUID 1
/* #undef HAVE_GETHOSTBYNAME_R */
/* #undef HAVE_GETHOSTBYNAME_R_3_ARG */
/* #undef HAVE_GETHOSTBYNAME_R_5_ARG */
/* #undef HAVE_GETHOSTBYNAME_R_6_ARG */
#define HAVE_GETNAMEINFO 1
#define HAVE_GETPROTOBYNUMBER 1
/* #undef HAVE_GETSERVBYNAME */
#define HAVE_GETTIMEOFDAY 1
#define HAVE_INET_ATON 1
#define HAVE_INET_NTOP 1
#define HAVE_INET_PTON 1
#define HAVE_INTTYPES_H 1
#define HAVE_ISSETUGID 1
/* #undef HAVE_KQUEUE */
/* #undef HAVE_LIBZ */
#define HAVE_MEMORY_H 1
#define HAVE_MMAP 1
#define HAVE_NETDB_H 1
/* #undef HAVE_NETINET_IN6_H */
#define HAVE_NETINET_IN_H 1
/* #undef HAVE_OPENSSL */
/* #undef HAVE_OPENSSL_BIO_H */
#define HAVE_PIPE 1
#define HAVE_POLL_H 1
/* #undef HAVE_PORT_CREATE */
/* #undef HAVE_PORT_H */
/* #undef HAVE_PTHREAD */
#define HAVE_PTHREADS 1
#define HAVE_PUTENV 1
#define HAVE_SA_FAMILY_T 1
#define HAVE_SENDFILE 1
#define HAVE_SETENV 1
#define HAVE_SETFD 1
#define HAVE_SIGACTION 1
#define HAVE_SIGNAL 1
#define HAVE_SPLICE 1
#define HAVE_STDARG_H 1
#define HAVE_STDDEF_H 1
#define HAVE_STDINT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_STRLCPY 1
#define HAVE_STRSEP 1
#define HAVE_STRTOK_R 1
#define HAVE_STRTOLL 1
#define HAVE_STRUCT_ADDRINFO 1
#define HAVE_STRUCT_IN6_ADDR 1
#define HAVE_STRUCT_IN6_ADDR_S6_ADDR16 1
#define HAVE_STRUCT_IN6_ADDR_S6_ADDR32 1
#define HAVE_STRUCT_SOCKADDR_IN6 1
/* #undef HAVE_STRUCT_SOCKADDR_IN6_SIN6_LEN */
/* #undef HAVE_STRUCT_SOCKADDR_IN_SIN_LEN */
#define HAVE_STRUCT_SOCKADDR_STORAGE 1
#define HAVE_STRUCT_SOCKADDR_STORAGE_SS_FAMILY 1
/* #undef HAVE_STRUCT_SOCKADDR_STORAGE___SS_FAMILY */
/* #undef HAVE_SYSCTL */
/* #undef HAVE_SYS_DEVPOLL_H */
#define HAVE_SYS_EPOLL_H 1
#define HAVE_SYS_EVENTFD_H 1
/* #undef HAVE_SYS_EVENT_H */
#define HAVE_SYS_IOCTL_H 1
#define HAVE_SYS_MMAN_H 1
#define HAVE_SYS_PARAM_H 1
/* #undef HAVE_SYS_QUEUE_H */
#define HAVE_SYS_SELECT_H 1
#define HAVE_SYS_SENDFILE_H 1
#define HAVE_SYS_SOCKET_H 1
#define HAVE_SYS_STAT_H 1
/* #undef HAVE_SYS_SYSCTL_H */
#define HAVE_SYS_TIME_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_SYS_UIO_H 1
#define HAVE_SYS_WAIT_H 1
/* #undef HAVE_TAILQFOREACH */
#define HAVE_TIMERADD 1
#define HAVE_TIMERCLEAR 1
#define HAVE_TIMERCMP 1
#define HAVE_TIMERISSET 1
#define HAVE_UINT16_T 1
#define HAVE_UINT32_T 1
#define HAVE_UINT64_T 1
#define HAVE_UINT8_T 1
#define HAVE_UINTPTR_T 1
#define HAVE_UMASK 1
#define HAVE_UNISTD_H 1
#define HAVE_UNSETENV 1
#define HAVE_VASPRINTF 1
/* #undef HAVE_WORKING_KQUEUE */
/* #undef HAVE_ZLIB_H */
#define LT_OBJDIR ".libs/"
#define NUMERIC_VERSION 0x02001600
#define PACKAGE "libevent"
#define PACKAGE_BUGREPORT ""
#define PACKAGE_NAME ""
#define PACKAGE_STRING ""
#define PACKAGE_TARNAME ""
#define PACKAGE_URL ""
#define PACKAGE_VERSION ""
/* #undef PTHREAD_CREATE_JOINABLE */
#define SIZEOF_INT 4
#define SIZEOF_LONG 8
#define SIZEOF_LONG_LONG 8
#define SIZEOF_OFF_T 8
#define SIZEOF_PTHREAD_T 8
#define SIZEOF_SHORT 2
#define SIZEOF_SIZE_T 8
#define SIZEOF_VOID_P 8
#define STDC_HEADERS 1
#define TIME_WITH_SYS_TIME 1
#define VERSION "2.0.22-stable"
/* #undef __func__ */
/* #undef const */
#ifndef __cplusplus
/* #undef inline */
#endif
/* #undef pid_t */
/* #undef size_t */
/* #undef socklen_t */
/* #undef ssize_t */
