#include <config-posix.h>

/* #undef HAVE_FEENABLEEXCEPT */
/* #undef HAVE_LIBM */
#define HAVE_LIBZ 1
#define HAVE_MEMORY_H 1
#define LT_OBJDIR ".libs/"
#define PACKAGE "libpng"
#define PACKAGE_BUGREPORT "png-mng-implement@lists.sourceforge.net"
#define PACKAGE_NAME "libpng"
#define PACKAGE_STRING "libpng 1.6.31"
#define PACKAGE_TARNAME "libpng"
#define PACKAGE_URL ""
#define PACKAGE_VERSION "1.6.31"
/* #undef PNG_ARM_NEON_API_SUPPORTED */
/* #undef PNG_ARM_NEON_CHECK_SUPPORTED */
/* #undef PNG_ARM_NEON_OPT */
#define PNG_INTEL_SSE_OPT 1
/* #undef PNG_MIPS_MSA_API_SUPPORTED */
/* #undef PNG_MIPS_MSA_CHECK_SUPPORTED */
/* #undef PNG_MIPS_MSA_OPT */
/* #undef PNG_POWERPC_VSX_API_SUPPORTED */
/* #undef PNG_POWERPC_VSX_CHECK_SUPPORTED */
/* #undef PNG_POWERPC_VSX_OPT */
/* #undef TM_IN_SYS_TIME */
#define VERSION "1.6.31"
/* #undef const */
#define restrict __restrict
#if defined __SUNPRO_CC && !defined __RESTRICT
# define _Restrict
# define __restrict__
#endif
/* #undef size_t */
