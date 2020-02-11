/* Check that config.h is #included before system headers
#if defined(__GLIBC__) && !defined(__FreeBSD_kernel__) && !defined(__CONFIG_H__)
#  error config.h must be #included before system headers
#endif
#define __CONFIG_H__ 1
/* #undef ENABLE_NLS */
#define HAVE_DECL_BASENAME 1
#define HAVE_DECL_STPCPY 1
#define HAVE_DLFCN_H 1
#define HAVE_INTTYPES_H 1
#define HAVE_LIMITS_H 1
#define HAVE_MEMORY_H 1
#define HAVE_SIGSETJMP 1
#define HAVE_STDINT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_UNISTD_H 1
#define LT_OBJDIR ".libs/"
#define PACKAGE "opcodes"
#define PACKAGE_BUGREPORT ""
#define PACKAGE_NAME "opcodes"
#define PACKAGE_STRING "opcodes 2.34"
#define PACKAGE_TARNAME "opcodes"
#define PACKAGE_URL ""
#define PACKAGE_VERSION "2.34"
#define STDC_HEADERS 1
#define STRING_WITH_STRINGS 1
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
#define VERSION "2.34"
/* #undef _MINIX */
/* #undef _POSIX_1_SOURCE */
/* #undef _POSIX_SOURCE */
