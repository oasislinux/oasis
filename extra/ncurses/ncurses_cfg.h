#ifndef NC_CONFIG_H
#define NC_CONFIG_H

#include <config-posix.h>

#define PACKAGE "ncurses"
#define NCURSES_VERSION "6.0"
#define NCURSES_PATCHDATE 20150808
#define SYSTEM_NAME "linux-musl"
#define HAVE_LONG_FILE_NAMES 1
#define MIXEDCASE_FILENAMES 1
#define TERMINFO_DIRS "/share/terminfo"
#define TERMINFO "/share/terminfo"
#define HAVE_BIG_CORE 1
#define PURE_TERMINFO 1
#define USE_HOME_TERMINFO 1
#define USE_ROOT_ENVIRON 1
#define USE_LINKS 1
#define HAVE_LANGINFO_CODESET 1
#define USE_WIDEC_SUPPORT 1
#define NCURSES_WIDECHAR 1
#define NEED_WCHAR_H 1
#define HAVE_ASSUME_DEFAULT_COLORS 1
#define HAVE_CURSES_VERSION 1
#define HAVE_HAS_KEY 1
#define HAVE_RESIZETERM 1
#define HAVE_RESIZE_TERM 1
#define HAVE_TERM_ENTRY_H 1
#define HAVE_USE_DEFAULT_COLORS 1
#define HAVE_USE_SCREEN 1
#define HAVE_USE_WINDOW 1
#define HAVE_WRESIZE 1
#define NCURSES_EXT_FUNCS 1
#define NCURSES_SP_FUNCS 1
#define NCURSES_EXT_COLORS 1
#define NCURSES_EXT_PUTWIN 1
#define NCURSES_NO_PADDING 1
#define HAVE_MEMORY_H 1
#define SIZEOF_SIGNED_CHAR 1
#define USE_SIGWINCH 1
#define USE_ASSUMED_COLOR 1
#define USE_HASHMAP 1
#define NCURSES_WRAP_PREFIX "_nc_"
#define GCC_SCANF 1
#define GCC_SCANFLIKE(fmt,var) __attribute__((format(scanf,fmt,var)))
#define GCC_PRINTF 1
#define GCC_PRINTFLIKE(fmt,var) __attribute__((format(printf,fmt,var)))
#define GCC_UNUSED __attribute__((unused))
#define GCC_NORETURN __attribute__((noreturn))
#define HAVE_NC_ALLOC_H 1
#define TIME_WITH_SYS_TIME 1
#define HAVE_REGEX_H_FUNCS 1
#define HAVE_GETOPT_H 1
#define HAVE_SYS_IOCTL_H 1
#define HAVE_SYS_PARAM_H 1
#define HAVE_SYS_POLL_H 1
#define HAVE_GETOPT_H 1
#define HAVE_GETOPT_HEADER 1
#define HAVE_SYS_TIME_SELECT 1
#define SIG_ATOMIC_T volatile sig_atomic_t
#define HAVE_ISSETUGID 1
#define HAVE_SETBUFFER 1
#define SETVBUF_REVERSED 1
#define HAVE_SIZECHANGE 1
#define HAVE_WORKING_POLL 1
#define USE_OPENPTY_HEADER <pty.h>
#define USE_XTERM_PTY 1
#define HAVE_TYPEINFO 1
#define HAVE_IOSTREAM 1
#define IOSTREAM_NAMESPACE 1
#define CPP_HAS_STATIC_CAST 1
#define SIZEOF_WCHAR_T 4
#define HAVE_SLK_COLOR 1
#define HAVE_PANEL_H 1
#define HAVE_LIBPANEL 1
#define HAVE_MENU_H 1
#define HAVE_LIBMENU 1
#define HAVE_FORM_H 1
#define HAVE_LIBFORM 1
#define NCURSES_PATHSEP ':'
#define NCURSES_VERSION_STRING "6.0.20150808"
#define NCURSES_OSPEED_COMPAT 1

#include <ncurses_def.h>

#endif /* NC_CONFIG_H */
