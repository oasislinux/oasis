#include <config-posix.h>

#define HAVE_DIRENT_NAMLEN 0
#define HAVE_ERR 1
#define HAVE_FTS 1
#define HAVE_PLEDGE 0
#define HAVE_PROGNAME 1
#define HAVE_REALLOCARRAY 1
#define HAVE_REWB_BSD 0
#define HAVE_REWB_SYSV 1
#define HAVE_SANDBOX_INIT 0
#define HAVE_STRCASESTR 1
#define HAVE_STRINGLIST 0
#define HAVE_STRLCAT 1
#define HAVE_STRLCPY 1
#define HAVE_STRSEP 1
#define HAVE_STRTONUM 1
#define HAVE_VASPRINTF 1
#define HAVE_WCHAR 1
#define HAVE_SQLITE3 0
#define HAVE_SQLITE3_ERRSTR 0
#define HAVE_OHASH 0
#define HAVE_MANPATH 0

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

/* paths */
#define MAN_CONF_FILE "/etc/man.conf"
#define MANPATH_DEFAULT "/share/man"
