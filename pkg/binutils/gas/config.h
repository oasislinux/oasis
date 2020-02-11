#if defined(__GLIBC__) && !defined(__FreeBSD_kernel__) && !defined(__CONFIG_H__)
#  error config.h must be #included before system headers
#endif
#define __CONFIG_H__ 1
/* #undef AC_APPLE_UNIVERSAL_BUILD */
/* #undef AIX_WEAK_SUPPORT */
/* #undef BROKEN_ASSERT */
/* #undef CRAY_STACKSEG_END */
/* #undef CROSS_COMPILE */
/* #undef C_ALLOCA */
#define DEFAULT_ARCH "x86_64"
/* #undef DEFAULT_CRIS_ARCH */
#define DEFAULT_EMULATION "i386elf"
#define DEFAULT_FLAG_COMPRESS_DEBUG 1
#define DEFAULT_GENERATE_BUILD_NOTES 0
#define DEFAULT_GENERATE_ELF_STT_COMMON 0
#define DEFAULT_GENERATE_X86_RELAX_RELOCATIONS 1
#define DEFAULT_MIPS_FIX_LOONGSON3_LLSC 0
#define DEFAULT_RISCV_ATTR 0
#define DEFAULT_X86_USED_NOTE 0
#define EMULATIONS &i386elf,
/* #undef ENABLE_CHECKING */
/* #undef ENABLE_NLS */
#define HAVE_ALLOCA 1
#define HAVE_ALLOCA_H 1
#define HAVE_DECL_ASPRINTF 1
#define HAVE_DECL_FREE 1
#define HAVE_DECL_GETENV 1
#define HAVE_DECL_GETOPT 1
#define HAVE_DECL_MALLOC 1
#define HAVE_DECL_MEMPCPY 1
#define HAVE_DECL_REALLOC 1
#define HAVE_DECL_STPCPY 1
#define HAVE_DECL_STRSTR 1
#define HAVE_DECL_VSNPRINTF 1
#define HAVE_DLFCN_H 1
#define HAVE_ERRNO_H 1
#define HAVE_INTTYPES_H 1
#define HAVE_LC_MESSAGES 1
#define HAVE_LIMITS_H 1
#define HAVE_LOCALE_H 1
#define HAVE_MEMORY_H 1
/* #undef HAVE_REMOVE */
#define HAVE_SBRK 1
#define HAVE_SETLOCALE 1
#define HAVE_STDINT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_STRSIGNAL 1
#define HAVE_ST_MTIM_TV_NSEC 1
#define HAVE_ST_MTIM_TV_SEC 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_TIME_H 1
#define HAVE_TM_GMTOFF 1
#define HAVE_UNISTD_H 1
#define HAVE_UNLINK 1
/* #undef HAVE_WINDOWS_H */
/* #undef I386COFF */
#define LT_OBJDIR ".libs/"
/* #undef MIPS_CPU_STRING_DEFAULT */
/* #undef MIPS_DEFAULT_64BIT */
/* #undef MIPS_DEFAULT_ABI */
/* #undef NDS32_DEFAULT_ARCH_NAME */
/* #undef NDS32_DEFAULT_AUDIO_EXT */
/* #undef NDS32_DEFAULT_DSP_EXT */
/* #undef NDS32_DEFAULT_DX_REGS */
/* #undef NDS32_DEFAULT_PERF_EXT */
/* #undef NDS32_DEFAULT_PERF_EXT2 */
/* #undef NDS32_DEFAULT_STRING_EXT */
/* #undef NDS32_DEFAULT_ZOL_EXT */
/* #undef NDS32_LINUX_TOOLCHAIN */
/* #undef NEED_DECLARATION_ENVIRON */
/* #undef NEED_DECLARATION_ERRNO */
/* #undef NEED_DECLARATION_FFS */
/* #undef NEED_DECLARATION_FREE */
/* #undef NEED_DECLARATION_MALLOC */
/* #undef NEED_DECLARATION_SBRK */
/* #undef NEED_DECLARATION_STRSTR */
/* #undef OBJ_MAYBE_AOUT */
/* #undef OBJ_MAYBE_COFF */
/* #undef OBJ_MAYBE_ECOFF */
/* #undef OBJ_MAYBE_ELF */
/* #undef OBJ_MAYBE_GENERIC */
/* #undef OBJ_MAYBE_SOM */
#define PACKAGE "gas"
#define PACKAGE_BUGREPORT ""
#define PACKAGE_NAME "gas"
#define PACKAGE_STRING "gas 2.34"
#define PACKAGE_TARNAME "gas"
#define PACKAGE_URL ""
#define PACKAGE_VERSION "2.34"
/* #undef STACK_DIRECTION */
#define STDC_HEADERS 1
/* #undef STRICTCOFF */
#define STRING_WITH_STRINGS 1
#define TARGET_ALIAS "x86_64-linux-musl"
/* #undef TARGET_BYTES_BIG_ENDIAN */
#define TARGET_CANONICAL "x86_64-pc-linux-musl"
#define TARGET_CPU "x86_64"
#define TARGET_OS "linux-musl"
/* #undef TARGET_SOLARIS_COMMENT */
#define TARGET_VENDOR "pc"
/* #undef TARGET_WITH_CPU */
/* #undef USE_BINARY_FOPEN */
/* #undef USE_EMULATIONS */
/* #undef USE_E_MIPS_ABI_O32 */
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
/* #undef USING_CGEN */
#define VERSION "2.34"
#if defined AC_APPLE_UNIVERSAL_BUILD
# if defined __BIG_ENDIAN__
#  define WORDS_BIGENDIAN 1
# endif
#else
# ifndef WORDS_BIGENDIAN
/* #  undef WORDS_BIGENDIAN */
# endif
#endif
/* #undef YYTEXT_POINTER */
#ifndef _DARWIN_USE_64_BIT_INODE
# define _DARWIN_USE_64_BIT_INODE 1
#endif
/* #undef _FILE_OFFSET_BITS */
/* #undef _LARGE_FILES */
/* #undef _MINIX */
/* #undef _POSIX_1_SOURCE */
/* #undef _POSIX_SOURCE */
#ifndef __cplusplus
/* #undef inline */
#endif
/* #undef size_t */
