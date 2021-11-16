#define BINDIR "/bin"
#define SYSDIR "/etc"

#define	SECURE		SECURE_COMPILE
#define	SHELL_ESCAPE	(!SECURE)
#define	EXAMINE		(!SECURE)
#define	TAB_COMPLETE_FILENAME	(!SECURE)
#define	CMD_HISTORY	1
#define	HILITE_SEARCH	1
#define	EDITOR		(!SECURE)
#define	TAGS		(!SECURE)
#define	USERFILE	(!SECURE)
#define	GLOB		(!SECURE)
#define	PIPEC		(!SECURE && HAVE_POPEN)
#define	LOGFILE		(!SECURE)
#define	GNU_OPTIONS	1
#define	ONLY_RETURN	0
#define	LESSKEYFILE		".less"
#define	LESSKEYFILE_SYS		SYSDIR "/sysless"
#define	DEF_LESSKEYINFILE	".lesskey"
#define	LESSKEYINFILE_SYS	SYSDIR "/syslesskey"
#define LESSHISTFILE		".lesshst"
#define	MSDOS_COMPILER	0
#define	PATHNAME_SEP	"/"
#define TGETENT_OK  1
#define HAVE_ANSI_PROTOS 1
#define HAVE_SYS_TYPES_H 1
/* #undef HAVE_SGSTAT_H */
#define	HAVE_PERROR	1
#define	HAVE_TIME	1
#define	HAVE_SHELL	1
#define	DEF_METACHARS	"; *?\t\n'\"()<>[]|&^`#\\$%=~{},"
#define	DEF_METAESCAPE	"\\"
#define	HAVE_DUP	1
#define HAVE_MEMCPY 1
#define HAVE_STRCHR 1
#define HAVE_STRSTR 1
#define HAVE_LESSKEYSRC 1
#if 0 /* old sizes for small memory machines */
#define	CMDBUF_SIZE	512	/* Buffer for multichar commands */
#define	UNGOT_SIZE	100	/* Max chars to unget() */
#define	LINEBUF_SIZE	1024	/* Max size of line in input file */
#define	OUTBUF_SIZE	1024	/* Output buffer */
#define	PROMPT_SIZE	200	/* Max size of prompt string */
#define	TERMBUF_SIZE	2048	/* Termcap buffer for tgetent */
#define	TERMSBUF_SIZE	1024	/* Buffer to hold termcap strings */
#define	TAGLINE_SIZE	512	/* Max size of line in tags file */
#define	TABSTOP_MAX	32	/* Max number of custom tab stops */
#else /* more reasonable sizes for modern machines */
#define	CMDBUF_SIZE	2048	/* Buffer for multichar commands */
#define	UNGOT_SIZE	200	/* Max chars to unget() */
#define	LINEBUF_SIZE	1024	/* Initial max size of line in input file */
#define	OUTBUF_SIZE	1024	/* Output buffer */
#define	PROMPT_SIZE	2048	/* Max size of prompt string */
#define	TERMBUF_SIZE	2048	/* Termcap buffer for tgetent */
#define	TERMSBUF_SIZE	1024	/* Buffer to hold termcap strings */
#define	TAGLINE_SIZE	1024	/* Max size of line in tags file */
#define	TABSTOP_MAX	128	/* Max number of custom tab stops */
#endif
#define EDIT_PGM "vi"
#define HAVE_CONST 1
#define HAVE_CTYPE_H 1
#define HAVE_ERRNO 1
#define HAVE_ERRNO_H 1
#define HAVE_FCHMOD 1
#define HAVE_FCNTL_H 1
#define HAVE_FILENO 1
#define HAVE_FLOAT 1
#define HAVE_FSYNC 1
/* #undef HAVE_GNU_REGEX */
#define HAVE_INTTYPES_H 1
#define HAVE_LIMITS_H 1
#define HAVE_LOCALE 1
#define HAVE_MEMORY_H 1
#define HAVE_NANOSLEEP 1
#define HAVE_OSPEED 1
/* #undef HAVE_PCRE */
/* #undef HAVE_PCRE2 */
#define HAVE_POLL 1
#define HAVE_POPEN 1
#define HAVE_POSIX_REGCOMP 1
#define HAVE_REALPATH 1
/* #undef HAVE_REGCMP */
/* #undef HAVE_REGEXEC2 */
/* #undef HAVE_RE_COMP */
#define HAVE_SIGEMPTYSET 1
#define HAVE_SIGPROCMASK 1
/* #undef HAVE_SIGSETMASK */
#define HAVE_SIGSET_T 1
#define HAVE_SNPRINTF 1
#define HAVE_STAT 1
#define HAVE_STAT_INO 1
#define HAVE_STDINT_H 1
#define HAVE_STDIO_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRERROR 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_SYSTEM 1
#define HAVE_SYS_ERRLIST 1
#define HAVE_SYS_IOCTL_H 1
#define HAVE_SYS_STAT_H 1
/* #undef HAVE_SYS_STREAM_H */
#define HAVE_SYS_TYPES_H 1
#define HAVE_TERMCAP_H 1
#define HAVE_TERMIOS_FUNCS 1
#define HAVE_TERMIOS_H 1
/* #undef HAVE_TERMIO_H */
#define HAVE_TIME_H 1
#define HAVE_TIME_T 1
#define HAVE_TTYNAME 1
#define HAVE_UNISTD_H 1
#define HAVE_UPPER_LOWER 1
#define HAVE_USLEEP 1
/* #undef HAVE_V8_REGCOMP */
#define HAVE_VALUES_H 1
#define HAVE_VOID 1
#define HAVE_WCTYPE 1
#define HAVE_WCTYPE_H 1
#define HAVE__SETJMP 1
/* #undef MUST_DEFINE_ERRNO */
/* #undef MUST_DEFINE_OSPEED */
/* #undef NO_REGEX */
#define PACKAGE_BUGREPORT ""
#define PACKAGE_NAME "less"
#define PACKAGE_STRING "less 1"
#define PACKAGE_TARNAME "less"
#define PACKAGE_URL ""
#define PACKAGE_VERSION "1"
#define RETSIGTYPE void
#define SECURE_COMPILE 0
/* #undef STAT_MACROS_BROKEN */
#define STDC_HEADERS 1
#define TIME_WITH_SYS_TIME 1
#ifndef _DARWIN_USE_64_BIT_INODE
# define _DARWIN_USE_64_BIT_INODE 1
#endif
/* #undef _FILE_OFFSET_BITS */
/* #undef _LARGE_FILES */
/* #undef const */
/* #undef off_t */
/* #undef size_t */
