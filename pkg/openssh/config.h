#include <config-posix.h>

#define ASKPASS_PROGRAM "/bin/ssh-askpass"
#define LOGIN_PROGRAM "/bin/login"
#define _PATH_BTMP "/var/log/btmp"
#define _PATH_PASSWD_PROG "/bin/passwd"
#define _PATH_SFTP_SERVER "/libexec/sftp-server"
#define _PATH_SSH_ASKPASS_DEFAULT "/bin/ssh-askpass"
#define _PATH_SSH_KEY_SIGN "/libexec/ssh-keysign"
#define _PATH_SSH_PIDDIR "/run"
#define _PATH_SSH_PKCS11_HELPER "/libexec/ssh-pkcs11-helper"
#define _PATH_SSH_PROGRAM "/bin/ssh"
#define _PATH_XAUTH "/dev/null/xauth"

/* #undef AC_APPLE_UNIVERSAL_BUILD */
/* #undef AIX_GETNAMEINFO_HACK */
/* #undef AIX_LOGINFAILED_4ARG */
/* #undef AU_IPv4 */
/* #undef BIND_8_COMPAT */
/* #undef BROKEN_BSM_API */
/* #undef BROKEN_CMSG_TYPE */
/* #undef BROKEN_GETADDRINFO */
/* #undef BROKEN_GETGROUPS */
/* #undef BROKEN_GLOB */
/* #undef BROKEN_INET_NTOA */
/* #undef BROKEN_LIBIAF */
/* #undef BROKEN_ONE_BYTE_DIRENT_D_NAME */
/* #undef BROKEN_READV_COMPARISON */
/* #undef BROKEN_READ_COMPARISON */
#define BROKEN_REALPATH 1
/* #undef BROKEN_SAVED_UIDS */
/* #undef BROKEN_SETREGID */
/* #undef BROKEN_SETRESGID */
/* #undef BROKEN_SETRESUID */
/* #undef BROKEN_SETREUID */
/* #undef BROKEN_SETVBUF */
/* #undef BROKEN_SHADOW_EXPIRE */
/* #undef BROKEN_SNPRINTF */
/* #undef BROKEN_STRNVIS */
/* #undef BROKEN_TCGETATTR_ICANON */
/* #undef BROKEN_UPDWTMPX */
/* #undef BSD_AUTH */
/* #undef CONF_LASTLOG_FILE */
/* #undef CONF_UTMP_FILE */
/* #undef CONF_WTMPX_FILE */
/* #undef CONF_WTMP_FILE */
/* #undef DISABLE_FD_PASSING */
/* #undef DISABLE_LASTLOG */
/* #undef DISABLE_LOGIN */
/* #undef DISABLE_PUTUTLINE */
/* #undef DISABLE_PUTUTXLINE */
/* #undef DISABLE_SHADOW */
/* #undef DISABLE_UTMP */
/* #undef DISABLE_UTMPX */
#define DISABLE_WTMP 1
#define DISABLE_WTMPX 1
#define ENABLE_PKCS11 1
/* #undef FILESYSTEM_NO_BACKSLASH */
/* #undef FSID_HAS_VAL */
/* #undef FSID_HAS___VAL */
#define GETPGRP_VOID 1
/* #undef GETSPNAM_CONFLICTING_DEFS */
/* #undef GLOB_HAS_ALTDIRFUNC */
/* #undef GLOB_HAS_GL_MATCHC */
/* #undef GLOB_HAS_GL_STATV */
/* #undef GSSAPI */
#define HAS_SHADOW_EXPIRE 1
/* #undef HAVE_ACCRIGHTS_IN_MSGHDR */
#define HAVE_ADDR_IN_UTMP 1
#define HAVE_ADDR_IN_UTMPX 1
#define HAVE_ADDR_V6_IN_UTMP 1
#define HAVE_ADDR_V6_IN_UTMPX 1
#define HAVE_ARC4RANDOM 1
#define HAVE_ARC4RANDOM_BUF 1
/* #undef HAVE_ARC4RANDOM_STIR */
#define HAVE_ARC4RANDOM_UNIFORM 1
#define HAVE_ASPRINTF 1
/* #undef HAVE_ATTRIBUTE__BOUNDED__ */
#define HAVE_ATTRIBUTE__NONNULL__ 1
/* #undef HAVE_ATTRIBUTE__SENTINEL__ */
/* #undef HAVE_AUG_GET_MACHINE */
/* #undef HAVE_B64_NTOP */
/* #undef HAVE_B64_PTON */
#define HAVE_BCOPY 1
/* #undef HAVE_BCRYPT_PBKDF */
/* #undef HAVE_BINDRESVPORT_SA */
/* #undef HAVE_BLF_ENC */
/* #undef HAVE_BLF_H */
/* #undef HAVE_BLOWFISH_EXPAND0STATE */
/* #undef HAVE_BLOWFISH_EXPANDSTATE */
/* #undef HAVE_BLOWFISH_INITSTATE */
/* #undef HAVE_BLOWFISH_STREAM2WORD */
#define HAVE_BN_IS_PRIME_EX 1
/* #undef HAVE_BSD_LIBUTIL_H */
/* #undef HAVE_BSM_AUDIT_H */
/* #undef HAVE_BSTRING_H */
/* #undef HAVE_CAP_RIGHTS_LIMIT */
/* #undef HAVE_CLOSEFROM */
#define HAVE_CONST_GAI_STRERROR_PROTO 1
#define HAVE_CONTROL_IN_MSGHDR 1
/* #undef HAVE_CRYPTO_SHA2_H */
#define HAVE_CRYPT_H 1
/* #undef HAVE_CYGWIN */
#define HAVE_DAEMON 1
#define HAVE_DECL_AI_NUMERICSERV 1
/* #undef HAVE_DECL_AUTHENTICATE */
#define HAVE_DECL_GLOB_NOMATCH 1
/* #undef HAVE_DECL_GSS_C_NT_HOSTBASED_SERVICE */
#define HAVE_DECL_HOWMANY 1
#define HAVE_DECL_H_ERRNO 1
/* #undef HAVE_DECL_LOGINFAILED */
/* #undef HAVE_DECL_LOGINRESTRICTIONS */
/* #undef HAVE_DECL_LOGINSUCCESS */
#define HAVE_DECL_MAXSYMLINKS 1
#define HAVE_DECL_NFDBITS 1
#define HAVE_DECL_OFFSETOF 1
#define HAVE_DECL_O_NONBLOCK 1
/* #undef HAVE_DECL_PASSWDEXPIRED */
/* #undef HAVE_DECL_SETAUTHDB */
#define HAVE_DECL_SHUT_RD 1
#define HAVE_DECL_WRITEV 1
#define HAVE_DECL__GETLONG 0
#define HAVE_DECL__GETSHORT 0
#define HAVE_DES_CRYPT 1
/* #undef HAVE_DEV_PTMX */
/* #undef HAVE_DEV_PTS_AND_PTC */
#define HAVE_DSA_GENERATE_PARAMETERS_EX 1
#define HAVE_ELF_H 1
#define HAVE_ENDIAN_H 1
#define HAVE_ENDUTENT 1
#define HAVE_ERR 1
#define HAVE_ERRX 1
#define HAVE_ERR_H 1
/* #undef HAVE_ETC_DEFAULT_LOGIN */
#define HAVE_EVP_CIPHER_CTX_CTRL 1
#define HAVE_EVP_DIGESTFINAL_EX 1
#define HAVE_EVP_DIGESTINIT_EX 1
#define HAVE_EVP_MD_CTX_CLEANUP 1
#define HAVE_EVP_MD_CTX_COPY_EX 1
#define HAVE_EVP_MD_CTX_INIT 1
#define HAVE_EVP_RIPEMD160 1
#define HAVE_EVP_SHA256 1
#define HAVE_EXIT_IN_UTMP 1
#define HAVE_EXPLICIT_BZERO 1
/* #undef HAVE_FCNTL_CLOSEM */
#define HAVE_FD_MASK 1
#define HAVE_FEATURES_H 1
/* #undef HAVE_FLOATINGPOINT_H */
/* #undef HAVE_FMT_SCALED */
#define HAVE_FSTATFS 1
#define HAVE_FUTIMES 1
/* #undef HAVE_GETAUDIT */
/* #undef HAVE_GETAUDIT_ADDR */
#define HAVE_GETGROUPLIST 1
/* #undef HAVE_GETGRSET */
/* #undef HAVE_GETLASTLOGXBYNAME */
/* #undef HAVE_GETLUID */
#define HAVE_GETOPT_H 1
#define HAVE_GETOPT_OPTRESET 1
#define HAVE_GETPAGESIZE 1
/* #undef HAVE_GETPEEREID */
/* #undef HAVE_GETPEERUCRED */
/* #undef HAVE_GETPWANAM */
/* #undef HAVE_GETRRSETBYNAME */
/* #undef HAVE_GETSEUSERBYNAME */
/* #undef HAVE_GETTTYENT */
#define HAVE_GETUTENT 1
#define HAVE_GETUTID 1
#define HAVE_GETUTLINE 1
/* #undef HAVE_GETUTXUSER */
/* #undef HAVE_GET_DEFAULT_CONTEXT_WITH_LEVEL */
/* #undef HAVE_GROUP_FROM_GID */
/* #undef HAVE_GSSAPI_GENERIC_H */
/* #undef HAVE_GSSAPI_GSSAPI_GENERIC_H */
/* #undef HAVE_GSSAPI_GSSAPI_H */
/* #undef HAVE_GSSAPI_GSSAPI_KRB5_H */
/* #undef HAVE_GSSAPI_H */
/* #undef HAVE_GSSAPI_KRB5_H */
#define HAVE_HEADER_AD 1
#define HAVE_HMAC_CTX_INIT 1
#define HAVE_HOST_IN_UTMP 1
#define HAVE_HOST_IN_UTMPX 1
/* #undef HAVE_IAF_H */
/* #undef HAVE_IA_H */
#define HAVE_ID_IN_UTMP 1
#define HAVE_ID_IN_UTMPX 1
#define HAVE_INET_ATON 1
/* #undef HAVE_INNETGR */
#define HAVE_INT64_T 1
#define HAVE_INTXX_T 1
#define HAVE_IN_ADDR_T 1
#define HAVE_IN_PORT_T 1
/* #undef HAVE_KRB5_CC_NEW_UNIQUE */
/* #undef HAVE_KRB5_FREE_ERROR_MESSAGE */
/* #undef HAVE_KRB5_GET_ERROR_MESSAGE */
#define HAVE_LASTLOG_H 1
/* #undef HAVE_LDNS */
/* #undef HAVE_LIBAUDIT_H */
/* #undef HAVE_LIBBSM */
/* #undef HAVE_LIBCRYPT */
/* #undef HAVE_LIBDL */
/* #undef HAVE_LIBIAF */
/* #undef HAVE_LIBNETWORK */
/* #undef HAVE_LIBPAM */
/* #undef HAVE_LIBSOCKET */
/* #undef HAVE_LIBUTIL_H */
/* #undef HAVE_LIBXNET */
#define HAVE_LIBZ 1
#define HAVE_LINUX_AUDIT_H 1
#define HAVE_LINUX_FILTER_H 1
#define HAVE_LINUX_IF_TUN_H 1
#define HAVE_LINUX_SECCOMP_H 1
/* #undef HAVE_LOGIN */
/* #undef HAVE_LOGIN_CAP_H */
/* #undef HAVE_LOGIN_GETCAPBOOL */
/* #undef HAVE_LOGIN_H */
/* #undef HAVE_LOGOUT */
/* #undef HAVE_LOGWTMP */
#define HAVE_LONG_DOUBLE 1
#define HAVE_LONG_LONG 1
/* #undef HAVE_MAILLOCK_H */
/* #undef HAVE_MD5_CRYPT */
/* #undef HAVE_MD5_PASSWORDS */
#define HAVE_MEMORY_H 1
/* #undef HAVE_MEMSET_S */
/* #undef HAVE_NDIR_H */
/* #undef HAVE_NETGROUP_H */
/* #undef HAVE_NET_IF_TUN_H */
/* #undef HAVE_NEXT */
/* #undef HAVE_NGETADDRINFO */
/* #undef HAVE_NSLEEP */
/* #undef HAVE_OGETADDRINFO */
/* #undef HAVE_OLD_PAM */
/* #undef HAVE_OPENLOG_R */
#define HAVE_OPENPTY 1
#define HAVE_OPENSSL 1
/* #undef HAVE_OSF_SIA */
/* #undef HAVE_PAM_GETENVLIST */
/* #undef HAVE_PAM_PAM_APPL_H */
/* #undef HAVE_PAM_PUTENV */
#define HAVE_PATHS_H 1
#define HAVE_PID_IN_UTMP 1
#define HAVE_PLEDGE 1
#define HAVE_PRCTL 1
/* #undef HAVE_PRIV_BASICSET */
/* #undef HAVE_PRIV_H */
#define HAVE_PROC_PID 1
/* #undef HAVE_PSTAT */
#define HAVE_PTY_H 1
#define HAVE_PUTUTLINE 1
/* #undef HAVE_READPASSPHRASE */
/* #undef HAVE_READPASSPHRASE_H */
/* #undef HAVE_REALLOCARRAY */
#define HAVE_RLIMIT_NPROC /**/
/* #undef HAVE_RPC_TYPES_H */
/* #undef HAVE_RRESVPORT_AF */
#define HAVE_RSA_GENERATE_KEY_EX 1
#define HAVE_RSA_GET_DEFAULT_METHOD 1
/* #undef HAVE_SANDBOX_H */
/* #undef HAVE_SANDBOX_INIT */
/* #undef HAVE_SCAN_SCALED */
/* #undef HAVE_SECUREWARE */
/* #undef HAVE_SECURITY_PAM_APPL_H */
/* #undef HAVE_SETAUTHDB */
/* #undef HAVE_SETDTABLESIZE */
/* #undef HAVE_SETGROUPENT */
#define HAVE_SETGROUPS 1
#define HAVE_SETLINEBUF 1
/* #undef HAVE_SETLOGIN */
/* #undef HAVE_SETLUID */
/* #undef HAVE_SETPASSENT */
/* #undef HAVE_SETPCRED */
/* #undef HAVE_SETPFLAGS */
/* #undef HAVE_SETPPRIV */
/* #undef HAVE_SETPROCTITLE */
#define HAVE_SETRESGID 1
#define HAVE_SETRESUID 1
#define HAVE_SETUTENT 1
/* #undef HAVE_SETUTXDB */
/* #undef HAVE_SET_ID */
#define HAVE_SHA256_UPDATE 1
/* #undef HAVE_SHA2_H */
#define HAVE_SHADOW_H 1
/* #undef HAVE_SIGVEC */
#define HAVE_SO_PEERCRED 1
#define HAVE_SS_FAMILY_IN_SS 1
#define HAVE_STATFS 1
#define HAVE_STRCASESTR 1
#define HAVE_STRICT_MKSTEMP 1
#define HAVE_STRLCAT 1
#define HAVE_STRLCPY 1
#define HAVE_STRMODE 1
/* #undef HAVE_STRNVIS */
#define HAVE_STRSEP 1
#define HAVE_STRTONUM 1
/* #undef HAVE_STRUCT_PASSWD_PW_CHANGE */
/* #undef HAVE_STRUCT_PASSWD_PW_CLASS */
/* #undef HAVE_STRUCT_PASSWD_PW_EXPIRE */
#define HAVE_STRUCT_PASSWD_PW_GECOS 1
#define HAVE_STRUCT_SOCKADDR_IN6_SIN6_SCOPE_ID 1
#define HAVE_STRUCT_STAT_ST_BLKSIZE 1
/* #undef HAVE_SWAP32 */
/* #undef HAVE_SYSLEN_IN_UTMPX */
/* #undef HAVE_SYS_AUDIT_H */
/* #undef HAVE_SYS_BITYPES_H */
/* #undef HAVE_SYS_BSDTTY_H */
/* #undef HAVE_SYS_CAPABILITY_H */
/* #undef HAVE_SYS_CDEFS_H */
#define HAVE_SYS_DIR_H 1
/* #undef HAVE_SYS_ERRLIST */
#define HAVE_SYS_MOUNT_H 1
/* #undef HAVE_SYS_NDIR_H */
/* #undef HAVE_SYS_NERR */
#define HAVE_SYS_POLL_H 1
#define HAVE_SYS_PRCTL_H 1
/* #undef HAVE_SYS_PSTAT_H */
/* #undef HAVE_SYS_PTMS_H */
#define HAVE_SYS_PTRACE_H 1
/* #undef HAVE_SYS_STREAM_H */
#define HAVE_SYS_STROPTS_H 1
/* #undef HAVE_SYS_STRTIO_H */
/* #undef HAVE_SYS_SYSLOG_H */
#define HAVE_SYS_SYSMACROS_H 1
/* #undef HAVE_SYS_TIMERS_H */
/* #undef HAVE_TIME_IN_UTMP */
/* #undef HAVE_TIME_IN_UTMPX */
/* #undef HAVE_TIMINGSAFE_BCMP */
/* #undef HAVE_TMPDIR_H */
/* #undef HAVE_TTYENT_H */
#define HAVE_TV_IN_UTMP 1
#define HAVE_TV_IN_UTMPX 1
#define HAVE_TYPE_IN_UTMP 1
#define HAVE_TYPE_IN_UTMPX 1
/* #undef HAVE_UCRED_H */
#define HAVE_UINTXX_T 1
#define HAVE_UNSIGNED_LONG_LONG 1
#define HAVE_UPDWTMP 1
#define HAVE_UPDWTMPX 1
/* #undef HAVE_USERSEC_H */
/* #undef HAVE_USER_FROM_UID */
#define HAVE_USLEEP 1
/* #undef HAVE_UTIL_H */
#define HAVE_UTMPNAME 1
#define HAVE_UTMPXNAME 1
#define HAVE_UTMP_H 1
#define HAVE_U_CHAR 1
#define HAVE_U_INT 1
#define HAVE_U_INT64_T 1
#define HAVE_U_INTXX_T 1
#define HAVE_VASPRINTF 1
/* #undef HAVE_VIS_H */
#define HAVE_WARN 1
/* #undef HAVE__GETLONG */
/* #undef HAVE__GETPTY */
/* #undef HAVE__GETSHORT */
#define HAVE__RES_EXTERN 1
/* #undef HAVE___B64_NTOP */
/* #undef HAVE___B64_PTON */
#define HAVE___FUNCTION__ 1
#define HAVE___PROGNAME 1
/* #undef HAVE___SS_FAMILY_IN_SS */
/* #undef HAVE___VA_COPY */
#define HAVE___func__ 1
/* #undef HEIMDAL */
/* #undef IPADDR_IN_DISPLAY */
#define IPV4_IN_IPV6 1
/* #undef IP_TOS_IS_BROKEN */
/* #undef KRB5 */
/* #undef LASTLOG_WRITE_PUTUTXLINE */
#define LINK_OPNOTSUPP_ERRNO EPERM
#define LINUX_OOM_ADJUST 1
/* #undef LLONG_MAX */
/* #undef LLONG_MIN */
#define LOCKED_PASSWD_PREFIX "!"
/* #undef LOCKED_PASSWD_STRING */
/* #undef LOCKED_PASSWD_SUBSTR */
/* #undef LOGIN_NEEDS_UTMPX */
/* #undef MAIL_DIRECTORY */
/* #undef NEED_SETPGRP */
/* #undef NO_ATTRIBUTE_ON_RETURN_TYPE */
/* #undef NO_SSH_LASTLOG */
/* #undef NO_UID_RESTORATION_TEST */
/* #undef NO_X11_UNIX_SOCKETS */
/* #undef OPENSSL_EVP_DIGESTUPDATE_VOID */
#define OPENSSL_HAS_ECC 1
#define OPENSSL_HAS_NISTP256 1
#define OPENSSL_HAS_NISTP384 1
#define OPENSSL_HAS_NISTP521 1
#define OPENSSL_HAVE_EVPCTR 1
#define OPENSSL_HAVE_EVPGCM 1
/* #undef OPENSSL_LOBOTOMISED_AES */
#define OPENSSL_PRNG_ONLY 1
#define PACKAGE_BUGREPORT "openssh-unix-dev@mindrot.org"
#define PACKAGE_NAME "OpenSSH"
#define PACKAGE_STRING "OpenSSH Portable"
#define PACKAGE_TARNAME "openssh"
#define PACKAGE_URL ""
#define PACKAGE_VERSION "Portable"
/* #undef PAM_SUN_CODEBASE */
#define PAM_TTY_KLUDGE 1
/* #undef PASSWD_NEEDS_USERNAME */
/* #undef PLATFORM_SYS_DIR_UID */
/* #undef PRNGD_PORT */
/* #undef PRNGD_SOCKET */
/* #undef PTY_ZEROREAD */
/* #undef SANDBOX_CAPSICUM */
/* #undef SANDBOX_DARWIN */
/* #undef SANDBOX_NULL */
/* #undef SANDBOX_PLEDGE */
/* #undef SANDBOX_RLIMIT */
#define SANDBOX_SECCOMP_FILTER 1
/* #undef SANDBOX_SKIP_RLIMIT_FSIZE */
/* #undef SANDBOX_SKIP_RLIMIT_NOFILE */
/* #undef SANDBOX_SOLARIS */
/* #undef SANDBOX_SYSTRACE */
#define SECCOMP_AUDIT_ARCH AUDIT_ARCH_X86_64
/* #undef SETEUID_BREAKS_SETUID */
/* #undef SIZEOF_INT */
/* #undef SIZEOF_LONG_INT */
/* #undef SIZEOF_LONG_LONG_INT */
/* #undef SIZEOF_SHORT_INT */
/* #undef SKEY */
/* #undef SKEYCHALLENGE_4ARG */
#define SNPRINTF_CONST const
#define SPT_TYPE SPT_REUSEARGV
/* #undef SSHD_ACQUIRES_CTTY */
/* #undef SSHD_PAM_SERVICE */
/* #undef SSHPAM_CHAUTHTOK_NEEDS_RUID */
/* #undef SSH_AUDIT_EVENTS */
/* #undef SSH_IOBUFSZ */
#define SSH_PRIVSEP_USER "sshd"
#define SSH_TUN_COMPAT_AF 1
/* #undef SSH_TUN_FREEBSD */
#define SSH_TUN_LINUX 1
/* #undef SSH_TUN_NO_L2 */
/* #undef SSH_TUN_OPENBSD */
#define SSH_TUN_PREPEND_AF 1
/* #undef SUPERUSER_PATH */
/* #undef SYSLOG_R_SAFE_IN_SIGHAND */
/* #undef UNIXWARE_LONG_PASSWORDS */
#define USER_PATH "/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin"
/* #undef USE_AFS */
/* #undef USE_BSM_AUDIT */
#define USE_BTMP 1
/* #undef USE_LIBEDIT */
/* #undef USE_LINUX_AUDIT */
/* #undef USE_OPENSSL_ENGINE */
/* #undef USE_PAM */
/* #undef USE_PIPES */
/* #undef USE_SOLARIS_PRIVS */
/* #undef USE_SOLARIS_PROCESS_CONTRACTS */
/* #undef USE_SOLARIS_PROJECTS */
/* #undef WITH_ABBREV_NO_TTY */
/* #undef WITH_AIXAUTHENTICATE */
/* #undef WITH_IRIX_ARRAY */
/* #undef WITH_IRIX_AUDIT */
/* #undef WITH_IRIX_JOBS */
/* #undef WITH_IRIX_PROJECT */
#define WITH_OPENSSL 1
/* #undef WITH_SELINUX */
/* #undef WITH_SSH1 */
#if defined AC_APPLE_UNIVERSAL_BUILD
# if defined __BIG_ENDIAN__
#  define WORDS_BIGENDIAN 1
# endif
#else
# ifndef WORDS_BIGENDIAN
/* #  undef WORDS_BIGENDIAN */
# endif
#endif
/* #undef XAUTH_PATH */
#ifndef _DARWIN_USE_64_BIT_INODE
# define _DARWIN_USE_64_BIT_INODE 1
#endif
/* #undef _FILE_OFFSET_BITS */
/* #undef _LARGE_FILES */
/* #undef __res_state */
#ifndef __cplusplus
/* #undef inline */
#endif
/* #undef socklen_t */
