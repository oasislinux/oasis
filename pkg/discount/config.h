#ifndef __AC_MARKDOWN_D
#define __AC_MARKDOWN_D 1

#include <stdint.h>

#define OS_LINUX 1
#define THEME_CF 1
#define NORETURN _Noreturn
#define DWORD uint32_t
#define WORD uint16_t
#define BYTE uint8_t
#define HAVE_BASENAME 1
#define HAVE_LIBGEN_H 1
#define HAVE_STDLIB_H 1
#define HAVE_ALLOCA_H 1
#define HAVE_PWD_H 1
#define HAVE_GETPWUID 1
#define HAVE_SRANDOM 1
#define INITRNG(x) srandom(x)
#define HAVE_BZERO 1
#define HAVE_RANDOM 1
#define COINTOSS() (random()&1)
#define HAVE_STRCASECMP 1
#define HAVE_STRNCASECMP 1
#define HAVE_FCHDIR 1
#define TABSTOP 4
#define HAVE_MALLOC_H 1

#endif /* __AC_MARKDOWN_D */
