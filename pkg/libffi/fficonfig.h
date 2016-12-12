#include <config-posix.h>

/* #undef AC_APPLE_UNIVERSAL_BUILD */
/* #undef CRAY_STACKSEG_END */
/* #undef C_ALLOCA */
#define EH_FRAME_FLAGS "aw"
/* #undef FFI_DEBUG */
/* #undef FFI_EXEC_TRAMPOLINE_TABLE */
/* #undef FFI_MMAP_EXEC_EMUTRAMP_PAX */
/* #undef FFI_MMAP_EXEC_WRIT */
/* #undef FFI_NO_RAW_API */
/* #undef FFI_NO_STRUCTS */
#define HAVE_ALLOCA 1
#define HAVE_ALLOCA_H 1
#define HAVE_AS_ASCII_PSEUDO_OP 1
#define HAVE_AS_CFI_PSEUDO_OP 1
/* #undef HAVE_AS_REGISTER_PSEUDO_OP */
/* #undef HAVE_AS_SPARC_UA_PCREL */
#define HAVE_AS_STRING_PSEUDO_OP 1
#define HAVE_AS_X86_64_UNWIND_SECTION_TYPE 1
#define HAVE_AS_X86_PCREL 1
#define HAVE_HIDDEN_VISIBILITY_ATTRIBUTE 1
#define HAVE_LONG_DOUBLE 1
/* #undef HAVE_LONG_DOUBLE_VARIANT */
#define HAVE_MEMORY_H 1
#define HAVE_MKOSTEMP 1
#define HAVE_MMAP_ANON 1
#define HAVE_MMAP_DEV_ZERO 1
#define HAVE_MMAP_FILE 1
/* #undef HAVE_RO_EH_FRAME */
#define LT_OBJDIR ".libs/"
#define PACKAGE "libffi"
#define PACKAGE_BUGREPORT "http://github.com/atgreen/libffi/issues"
#define PACKAGE_NAME "libffi"
#define PACKAGE_STRING "libffi 3.2.1"
#define PACKAGE_TARNAME "libffi"
#define PACKAGE_URL ""
#define PACKAGE_VERSION "3.2.1"
#define SIZEOF_DOUBLE 8
#define SIZEOF_LONG_DOUBLE 16
#define SIZEOF_SIZE_T 8
/* #undef STACK_DIRECTION */
/* #undef SYMBOL_UNDERSCORE */
/* #undef USING_PURIFY */
#define VERSION "3.2.1"
#if defined AC_APPLE_UNIVERSAL_BUILD
# if defined __BIG_ENDIAN__
#  define WORDS_BIGENDIAN 1
# endif
#else
# ifndef WORDS_BIGENDIAN
/* #  undef WORDS_BIGENDIAN */
# endif
#endif
/* #undef size_t */
#ifdef HAVE_HIDDEN_VISIBILITY_ATTRIBUTE
#ifdef LIBFFI_ASM
#define FFI_HIDDEN(name) .hidden name
#else
#define FFI_HIDDEN __attribute__ ((visibility ("hidden")))
#endif
#else
#ifdef LIBFFI_ASM
#define FFI_HIDDEN(name)
#else
#define FFI_HIDDEN
#endif
#endif
