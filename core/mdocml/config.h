#include <config-posix.h>
#define HAVE_WCHAR 1

/* features */
#define HAVE_MANPATH 0
#define HAVE_SQLITE3 0
/* #undef HAVE_SQLITE3_ERRSTR */ /* only used DB support */
/* #undef HAVE_OHASH */ /* only used DB support */

/* types */
#define DIRENT_NAMLEN 0

/* functions */
#define HAVE_FGETLN 1
#define HAVE_STRCASESTR 1
#define HAVE_STRLCAT 1
#define HAVE_STRLCPY 1
#define HAVE_STRSEP 1

/* get these from OpenBSD */
#define HAVE_FTS 1
#define HAVE_REALLOCARRAY 1
#define HAVE_STRTONUM 1

/* macros */
#if !defined(__BEGIN_DECLS)
#  define       __BEGIN_DECLS
#endif
#if !defined(__END_DECLS)
#  define       __END_DECLS
#endif

/* binary names */
#define BINM_APROPOS "apropos"
#define BINM_MAN "man"
#define BINM_WHATIS "whatis"
#define BINM_MAKEWHATIS "makewhatis"
