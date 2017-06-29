#define DEFAULT_EDITOR "sam -d"
#define DEFAULT_GIT_TEMPLATE_DIR "share/git-core/templates"
#define DEFAULT_PAGER ""
#define ETC_GITATTRIBUTES "/etc/gitattributes"
#define ETC_GITCONFIG "/etc/gitconfig"
#define GIT_EXEC_PATH "libexec/git-core"
#define GIT_HTML_PATH "share/doc/git-doc"
#define GIT_INFO_PATH "share/info"
#define GIT_LOCALE_PATH "/share/locale"
#define GIT_MAN_PATH "share/man"
#define GIT_USER_AGENT "git/" GIT_VERSION
#define GIT_VERSION "2.13.2"
#define PAGER_ENV "LESS=FRX LV=-c"
#define NO_SYS_POLL_H
#define NO_OPENSSL
#define USE_CURL_FOR_IMAP_SEND

#define SHA1_DC
#define SHA1DC_NO_STANDARD_INCLUDES
#define SHA1DC_INIT_SAFE_HASH_DEFAULT 0
#define SHA1DC_CUSTOM_INCLUDE_SHA1_C "cache.h"
#define SHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_C "sha1dc_git.c"
#define SHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_H "sha1dc_git.h"
#define SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C "git-compat-util.h"
