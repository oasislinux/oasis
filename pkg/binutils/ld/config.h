#if defined(__GLIBC__) && !defined(__FreeBSD_kernel__) && !defined(__CONFIG_H__)
#  error config.h must be #included before system headers
#endif
#define __CONFIG_H__ 1
#define DEFAULT_EMIT_GNU_HASH 1
#define DEFAULT_EMIT_SYSV_HASH 0
/* #undef DEFAULT_FLAG_COMPRESS_DEBUG */
#define DEFAULT_LD_TEXTREL_CHECK textrel_check_warning
#define DEFAULT_LD_TEXTREL_CHECK_WARNING 1
#define DEFAULT_LD_Z_RELRO 1
#define DEFAULT_LD_Z_SEPARATE_CODE 1
#define DEFAULT_NEW_DTAGS 1
/* #undef ENABLE_CHECKING */
/* #undef ENABLE_LIBCTF */
/* #undef ENABLE_NLS */
/* #undef EXTRA_SHLIB_EXTENSION */
#define GOT_HANDLING_DEFAULT GOT_HANDLING_TARGET_DEFAULT
#define HAVE_CLOSE 1
#define HAVE_DECL_ASPRINTF 1
#define HAVE_DECL_ENVIRON 1
#define HAVE_DECL_GETOPT 1
#define HAVE_DECL_SBRK 1
#define HAVE_DLFCN_H 1
/* #undef HAVE_ELF_HINTS_H */
#define HAVE_FCNTL_H 1
#define HAVE_GETPAGESIZE 1
#define HAVE_GLOB 1
#define HAVE_INITFINI_ARRAY 1
#define HAVE_INTTYPES_H 1
#define HAVE_LC_MESSAGES 1
#define HAVE_LIMITS_H 1
#define HAVE_LSEEK 1
#define HAVE_MEMORY_H 1
#define HAVE_MKSTEMP 1
#define HAVE_MMAP 1
#define HAVE_OPEN 1
#define HAVE_REALPATH 1
#define HAVE_SBRK 1
#define HAVE_STDINT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_SYS_FILE_H 1
#define HAVE_SYS_MMAN_H 1
#define HAVE_SYS_PARAM_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_TIME_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_UNISTD_H 1
#define HAVE_WAITPID 1
/* #undef HAVE_WINDOWS_H */
#define LT_OBJDIR ".libs/"
#define PACKAGE "ld"
#define PACKAGE_BUGREPORT ""
#define PACKAGE_NAME "ld"
#define PACKAGE_STRING "ld 2.37"
#define PACKAGE_TARNAME "ld"
#define PACKAGE_URL ""
#define PACKAGE_VERSION "2.37"
#define SIZEOF_VOID_P 8
#define STDC_HEADERS 1
#define SUPPORT_ERROR_HANDLING_SCRIPT 1
/* #undef USE_BINARY_FOPEN */
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
#define VERSION "2.37"
/* #undef YYTEXT_POINTER */
#ifndef _DARWIN_USE_64_BIT_INODE
# define _DARWIN_USE_64_BIT_INODE 1
#endif
/* #undef _FILE_OFFSET_BITS */
/* #undef _LARGE_FILES */
/* #undef _MINIX */
/* #undef _POSIX_1_SOURCE */
/* #undef _POSIX_SOURCE */
