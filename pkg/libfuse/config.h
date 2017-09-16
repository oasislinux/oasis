#include <config-posix.h>

#define FUSERMOUNT_DIR "/bin"
#define IGNORE_MTAB

#undef HAVE_ICONV
#define HAVE_PIPE2
#define HAVE_SETXATTR
#define HAVE_SPLICE
#define HAVE_STRUCT_STAT_ST_ATIM
#undef HAVE_STRUCT_STAT_ST_ATIMESPEC
#define HAVE_VMSPLICE
#define PACKAGE_VERSION "3.1.1"
