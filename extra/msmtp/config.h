#include <config-posix.h>

/* features */
#define HAVE_LIBSSL 1
#define HAVE_TLS 1
/* #undef ENABLE_NLS */
/* #undef HAVE_GAI_IDN */
/* #undef HAVE_LIBGNUTLS */
/* #undef HAVE_LIBGSASL */
/* #undef HAVE_LIBIDN */
/* #undef HAVE_LIBSECRET */
/* #undef HAVE_MACOSXKEYRING */

/* headers */
#define HAVE_MEMORY_H
#define HAVE_SYSEXITS_H 1

/* types */
/* #undef SIZEOF_LONG_LONG */ /* not needed after _Static_assert patch */

/* functions */
#define HAVE_DCGETTEXT 1
#define HAVE_GETPASS 1
#define HAVE_GETTEXT 1
#define HAVE_VASPRINTF 1
/* #undef HAVE_CFLOCALECOPYCURRENT */
/* #undef HAVE_CFPREFERENCESCOPYAPPVALUE */
/* #undef HAVE_FSEEKO64 */

/* misc */
#define PACKAGE "msmtp"
#define PACKAGE_BUGREPORT "marlam@marlam.de"
#define PACKAGE_NAME "msmtp"
#define PACKAGE_STRING "msmtp 1.6.4"
#define PACKAGE_TARNAME "msmtp"
#define PACKAGE_URL "http://msmtp.sourceforge.net/"
#define PACKAGE_VERSION "1.6.4"
#define PLATFORM "linux"
#define VERSION "1.6.4"
