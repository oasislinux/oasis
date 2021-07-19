#if defined(__GLIBC__) && !defined(__FreeBSD_kernel__) && !defined(__CONFIG_H__)
#  error config.h must be #included before system headers
#endif
#define __CONFIG_H__ 1
#define DEFAULT_AR_DETERMINISTIC 1
#define DEFAULT_FOR_FOLLOW_LINKS 1
#define DEFAULT_F_FOR_IFUNC_SYMBOLS 0
#define DEFAULT_STRINGS_ALL 1
/* #undef ENABLE_CHECKING */
/* #undef ENABLE_LIBCTF */
/* #undef ENABLE_NLS */
#define EXECUTABLE_SUFFIX ""
#define HAVE_DECL_ASPRINTF 1
#define HAVE_DECL_ENVIRON 1
#define HAVE_DECL_GETC_UNLOCKED 1
#define HAVE_DECL_GETOPT 1
#define HAVE_DECL_SBRK 1
#define HAVE_DECL_STPCPY 1
#define HAVE_DECL_STRNLEN 1
#define HAVE_DLFCN_H 1
/* #undef HAVE_EXECUTABLE_SUFFIX */
#define HAVE_FCNTL_H 1
#define HAVE_GETC_UNLOCKED 1
#define HAVE_GETPAGESIZE 1
#define HAVE_GOOD_UTIME_H 1
#define HAVE_ICONV 1
#define HAVE_INTTYPES_H 1
#define HAVE_LC_MESSAGES 1
/* #undef HAVE_LIBDEBUGINFOD */
#define HAVE_MBSTATE_T 1
#define HAVE_MEMORY_H 1
#define HAVE_MKDTEMP 1
#define HAVE_MKSTEMP 1
#define HAVE_MMAP 1
#define HAVE_SBRK 1
#define HAVE_STDINT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
/* #undef HAVE_STRUCT_STAT_ST_ATIMENSEC */
/* #undef HAVE_STRUCT_STAT_ST_ATIMESPEC_TV_NSEC */
/* #undef HAVE_STRUCT_STAT_ST_ATIM_ST__TIM_TV_NSEC */
#define HAVE_STRUCT_STAT_ST_ATIM_TV_NSEC 1
#define HAVE_SYS_FILE_H 1
#define HAVE_SYS_PARAM_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_TIME_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_SYS_WAIT_H 1
#define HAVE_UNISTD_H 1
#define HAVE_UTIMENSAT 1
#define HAVE_UTIMES 1
/* #undef HAVE_WINDOWS_H */
#define ICONV_CONST 
#define LT_OBJDIR ".libs/"
#define PACKAGE "binutils"
#define PACKAGE_BUGREPORT ""
#define PACKAGE_NAME "binutils"
#define PACKAGE_STRING "binutils 2.37"
#define PACKAGE_TARNAME "binutils"
#define PACKAGE_URL ""
#define PACKAGE_VERSION "2.37"
#define SIZEOF_LONG 8
#define SIZEOF_LONG_LONG 8
#define STDC_HEADERS 1
#define TARGET "x86_64-pc-linux-musl"
#define TARGET_PREPENDS_UNDERSCORE 0
#define TYPEOF_STRUCT_STAT_ST_ATIM_IS_STRUCT_TIMESPEC 1
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
