#if defined(__GLIBC__) && !defined(__FreeBSD_kernel__) && !defined(__CONFIG_H__)
#  error config.h must be #included before system headers
#endif
#define __CONFIG_H__ 1
#define CORE_HEADER "hosts/x86-64linux.h"
#define DEFAULT_LD_Z_SEPARATE_CODE 1
/* #undef ENABLE_NLS */
#define HAVE_ALLOCA_H 1
#define HAVE_DECL_ASPRINTF 1
#define HAVE_DECL_BASENAME 1
#define HAVE_DECL_FFS 1
#define HAVE_DECL_FREE 1
#define HAVE_DECL_FSEEKO 1
#define HAVE_DECL_FSEEKO64 1
#define HAVE_DECL_FTELLO 1
#define HAVE_DECL_FTELLO64 1
#define HAVE_DECL_GETENV 1
#define HAVE_DECL_MALLOC 1
#define HAVE_DECL_REALLOC 1
#define HAVE_DECL_SNPRINTF 1
#define HAVE_DECL_STPCPY 1
#define HAVE_DECL_STRNLEN 1
#define HAVE_DECL_STRSTR 1
#define HAVE_DECL_VASPRINTF 1
#define HAVE_DECL_VSNPRINTF 1
#define HAVE_DIRENT_H 1
#define HAVE_DLFCN_H 1
#define HAVE_FCNTL 1
#define HAVE_FCNTL_H 1
#define HAVE_FDOPEN 1
#define HAVE_FILENO 1
/* #undef HAVE_FLS */
#define HAVE_FOPEN64 1
#define HAVE_FSEEKO 1
#define HAVE_FSEEKO64 1
#define HAVE_FTELLO 1
#define HAVE_FTELLO64 1
#define HAVE_GETGID 1
#define HAVE_GETPAGESIZE 1
#define HAVE_GETRLIMIT 1
#define HAVE_GETUID 1
#define HAVE_HIDDEN 1
#define HAVE_INTTYPES_H 1
#define HAVE_LIMITS_H 1
#define HAVE_LONG_DOUBLE 1
#define HAVE_LONG_LONG 1
/* #undef HAVE_LWPSTATUS_T */
/* #undef HAVE_LWPSTATUS_T_PR_CONTEXT */
/* #undef HAVE_LWPSTATUS_T_PR_FPREG */
/* #undef HAVE_LWPSTATUS_T_PR_REG */
/* #undef HAVE_LWPXSTATUS_T */
#define HAVE_MADVISE 1
#define HAVE_MEMORY_H 1
#define HAVE_MMAP 1
#define HAVE_MPROTECT 1
/* #undef HAVE_NDIR_H */
/* #undef HAVE_PRPSINFO32_T */
/* #undef HAVE_PRPSINFO32_T_PR_PID */
#define HAVE_PRPSINFO_T 1
#define HAVE_PRPSINFO_T_PR_PID 1
/* #undef HAVE_PRSTATUS32_T */
/* #undef HAVE_PRSTATUS32_T_PR_WHO */
#define HAVE_PRSTATUS_T 1
/* #undef HAVE_PRSTATUS_T_PR_WHO */
/* #undef HAVE_PSINFO32_T */
/* #undef HAVE_PSINFO32_T_PR_PID */
/* #undef HAVE_PSINFO_T */
/* #undef HAVE_PSINFO_T_PR_PID */
/* #undef HAVE_PSTATUS32_T */
/* #undef HAVE_PSTATUS_T */
/* #undef HAVE_PXSTATUS_T */
#define HAVE_SETITIMER 1
#define HAVE_STDDEF_H 1
#define HAVE_STDINT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_STRTOULL 1
/* #undef HAVE_ST_C_IMPL */
#define HAVE_SYSCONF 1
/* #undef HAVE_SYS_DIR_H */
#define HAVE_SYS_FILE_H 1
/* #undef HAVE_SYS_NDIR_H */
#define HAVE_SYS_PARAM_H 1
#define HAVE_SYS_PROCFS_H 1
#define HAVE_SYS_RESOURCE_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_TIME_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_TIME_H 1
#define HAVE_UNISTD_H 1
#define HAVE_WCHAR_H 1
#define HAVE_WCTYPE_H 1
/* #undef HAVE_WIN32_PSTATUS_T */
/* #undef HAVE_WINDOWS_H */
#define LT_OBJDIR ".libs/"
#define PACKAGE "bfd"
#define PACKAGE_BUGREPORT ""
#define PACKAGE_NAME "bfd"
#define PACKAGE_STRING "bfd 2.36.1"
#define PACKAGE_TARNAME "bfd"
#define PACKAGE_URL ""
#define PACKAGE_VERSION "2.36.1"
/* #undef SIZEOF_CHAR */
#define SIZEOF_INT 4
#define SIZEOF_LONG 8
#define SIZEOF_LONG_LONG 8
#define SIZEOF_OFF_T 8
/* #undef SIZEOF_SHORT */
#define SIZEOF_VOID_P 8
#define STDC_HEADERS 1
#define STRING_WITH_STRINGS 1
#define TIME_WITH_SYS_TIME 1
/* #undef TRAD_HEADER */
/* #undef USE_64_BIT_ARCHIVE */
/* #undef USE_BINARY_FOPEN */
/* #undef USE_MINGW64_LEADING_UNDERSCORES */
/* #undef USE_MMAP */
#define USE_SECUREPLT 1
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
#define VERSION "2.36.1"
#ifndef _DARWIN_USE_64_BIT_INODE
# define _DARWIN_USE_64_BIT_INODE 1
#endif
/* #undef _FILE_OFFSET_BITS */
/* #undef _LARGE_FILES */
/* #undef _MINIX */
/* #undef _POSIX_1_SOURCE */
/* #undef _POSIX_SOURCE */
#define _STRUCTURED_PROC 1
