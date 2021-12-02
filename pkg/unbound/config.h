#define ATTR_NORETURN __attribute__((noreturn))
#define ATTR_WEAK __attribute__((weak))
#define CHROOT_DIR "/etc/unbound"
/* #undef CLIENT_SUBNET */
/* #undef COMPAT_SHA512 */
#define CONFCMDLINE "--prefix= --with-bearssl --disable-ed25519 --disable-ed448"
#define CONFIGFILE "/etc/unbound/unbound.conf"
/* #undef DARWIN_BROKEN_SETREUID */
/* #undef DEPRECATED_DAEMON */
/* #undef DEPRECATE_RSA_1024 */
/* #undef DISABLE_EXPLICIT_PORT_RANDOMISATION */
/* #undef DNSTAP_SOCKET_PATH */
/* #undef ENABLE_LOCK_CHECKS */
/* #undef EXPORT_ALL_SYMBOLS */
#define HAVE_ACCEPT4 1
/* #undef HAVE_ARC4RANDOM */
/* #undef HAVE_ARC4RANDOM_UNIFORM */
#define HAVE_ARPA_INET_H 1
#define HAVE_ATTR_FORMAT 1
#define HAVE_ATTR_NORETURN 1
#define HAVE_ATTR_UNUSED 1
#define HAVE_ATTR_WEAK 1
#define HAVE_BE64TOH 1
#define HAVE_BEARSSL 1
/* #undef HAVE_BIO_SET_CALLBACK_EX */
/* #undef HAVE_BSD_STDLIB_H */
/* #undef HAVE_BSD_STRING_H */
#define HAVE_CHOWN 1
#define HAVE_CHROOT 1
/* #undef HAVE_CRYPTO_CLEANUP_ALL_EX_DATA */
/* #undef HAVE_CRYPTO_THREADID_SET_CALLBACK */
#define HAVE_CTIME_R 1
#define HAVE_DAEMON 1
/* #undef HAVE_DECL_ARC4RANDOM */
/* #undef HAVE_DECL_ARC4RANDOM_UNIFORM */
/* #undef HAVE_DECL_EVSIGNAL_ASSIGN */
#define HAVE_DECL_INET_NTOP 1
#define HAVE_DECL_INET_PTON 1
/* #undef HAVE_DECL_NGHTTP2_SESSION_SERVER_NEW */
/* #undef HAVE_DECL_NID_ED25519 */
/* #undef HAVE_DECL_NID_ED448 */
/* #undef HAVE_DECL_NID_SECP384R1 */
/* #undef HAVE_DECL_NID_X9_62_PRIME256V1 */
#define HAVE_DECL_REALLOCARRAY 1
/* #undef HAVE_DECL_REDISCONNECT */
/* #undef HAVE_DECL_SK_SSL_COMP_POP_FREE */
/* #undef HAVE_DECL_SSL_COMP_GET_COMPRESSION_METHODS */
/* #undef HAVE_DECL_SSL_CTX_SET_ECDH_AUTO */
/* #undef HAVE_DECL_STRLCAT */
/* #undef HAVE_DECL_STRLCPY */
#define HAVE_DECL_XML_STOPPARSER 1
#define HAVE_DLFCN_H 1
/* #undef HAVE_DSA_SIG_SET0 */
#define HAVE_ENDIAN_H 1
#define HAVE_ENDPROTOENT 1
#define HAVE_ENDPWENT 1
#define HAVE_ENDSERVENT 1
/* #undef HAVE_ENGINE_CLEANUP */
/* #undef HAVE_ERR_FREE_STRINGS */
/* #undef HAVE_ERR_LOAD_CRYPTO_STRINGS */
/* #undef HAVE_EVENT_ASSIGN */
/* #undef HAVE_EVENT_BASE_FREE */
/* #undef HAVE_EVENT_BASE_GET_METHOD */
/* #undef HAVE_EVENT_BASE_NEW */
/* #undef HAVE_EVENT_BASE_ONCE */
/* #undef HAVE_EVENT_H */
/* #undef HAVE_EVP_AES_256_CBC */
/* #undef HAVE_EVP_CLEANUP */
/* #undef HAVE_EVP_DIGESTVERIFY */
/* #undef HAVE_EVP_DSS1 */
/* #undef HAVE_EVP_ENCRYPTINIT_EX */
/* #undef HAVE_EVP_MAC_CTX_SET_PARAMS */
/* #undef HAVE_EVP_MD_CTX_NEW */
/* #undef HAVE_EVP_SHA1 */
/* #undef HAVE_EVP_SHA256 */
/* #undef HAVE_EVP_SHA512 */
/* #undef HAVE_EV_DEFAULT_LOOP */
/* #undef HAVE_EV_LOOP */
#define HAVE_EXPAT_H 1
#define HAVE_EXPLICIT_BZERO 1
#define HAVE_FCNTL 1
/* #undef HAVE_FIPS_MODE */
#define HAVE_FORK 1
#define HAVE_FSEEKO 1
#define HAVE_FSYNC 1
#define HAVE_GETADDRINFO 1
/* #undef HAVE_GETAUXVAL */
#define HAVE_GETENTROPY 1
#define HAVE_GETIFADDRS 1
#define HAVE_GETOPT_H 1
#define HAVE_GETPWNAM 1
#define HAVE_GETRLIMIT 1
#define HAVE_GLOB 1
#define HAVE_GLOB_H 1
#define HAVE_GMTIME_R 1
#define HAVE_GRP_H 1
/* #undef HAVE_HIREDIS_HIREDIS_H */
/* #undef HAVE_HMAC_INIT_EX */
#define HAVE_HTOBE64 1
#define HAVE_IFADDRS_H 1
#define HAVE_IF_NAMETOINDEX 1
#define HAVE_INET_ATON 1
#define HAVE_INET_NTOP 1
#define HAVE_INET_PTON 1
#define HAVE_INITGROUPS 1
#define HAVE_INTTYPES_H 1
/* #undef HAVE_IOCTLSOCKET */
/* #undef HAVE_IPHLPAPI_H */
#define HAVE_ISBLANK 1
#define HAVE_KILL 1
/* #undef HAVE_LIBBSD */
/* #undef HAVE_LIBKERN_OSBYTEORDER_H */
/* #undef HAVE_LIBRESSL */
#define HAVE_LOCALTIME_R 1
/* #undef HAVE_LOGIN_CAP_H */
#define HAVE_MALLOC 1
#define HAVE_MEMMOVE 1
#define HAVE_MEMORY_H 1
#define HAVE_NETDB_H 1
#define HAVE_NETINET_IN_H 1
#define HAVE_NETINET_TCP_H 1
/* #undef HAVE_NETTLE */
/* #undef HAVE_NETTLE_DSA_COMPAT_H */
/* #undef HAVE_NETTLE_EDDSA_H */
#define HAVE_NET_IF_H 1
/* #undef HAVE_NGHTTP2 */
/* #undef HAVE_NGHTTP2_NGHTTP2_H */
/* #undef HAVE_NSS */
/* #undef HAVE_OPENSSL_ADD_ALL_DIGESTS */
/* #undef HAVE_OPENSSL_BN_H */
/* #undef HAVE_OPENSSL_CONFIG */
/* #undef HAVE_OPENSSL_CONF_H */
/* #undef HAVE_OPENSSL_CORE_NAMES_H */
/* #undef HAVE_OPENSSL_DH_H */
/* #undef HAVE_OPENSSL_DSA_H */
/* #undef HAVE_OPENSSL_ENGINE_H */
/* #undef HAVE_OPENSSL_ERR_H */
/* #undef HAVE_OPENSSL_INIT_CRYPTO */
/* #undef HAVE_OPENSSL_INIT_SSL */
/* #undef HAVE_OPENSSL_PARAM_BUILD_H */
/* #undef HAVE_OPENSSL_RAND_H */
/* #undef HAVE_OPENSSL_RSA_H */
/* #undef HAVE_OPENSSL_SSL_H */
/* #undef HAVE_OSSL_PARAM_BLD_NEW */
#define HAVE_PTHREAD 1
#define HAVE_PTHREAD_PRIO_INHERIT 1
#define HAVE_PTHREAD_RWLOCK_T 1
#define HAVE_PTHREAD_SPINLOCK_T 1
#define HAVE_PWD_H 1
/* #undef HAVE_PYTHON */
#define HAVE_RANDOM 1
/* #undef HAVE_RAND_CLEANUP */
#define HAVE_REALLOCARRAY 1
#define HAVE_RECVMSG 1
#define HAVE_SENDMSG 1
/* #undef HAVE_SETREGID */
#define HAVE_SETRESGID 1
#define HAVE_SETRESUID 1
/* #undef HAVE_SETREUID */
#define HAVE_SETRLIMIT 1
#define HAVE_SETSID 1
/* #undef HAVE_SETUSERCONTEXT */
/* #undef HAVE_SHA512_UPDATE */
#define HAVE_SHMGET 1
#define HAVE_SIGPROCMASK 1
#define HAVE_SLEEP 1
#define HAVE_SNPRINTF 1
#define HAVE_SOCKETPAIR 1
/* #undef HAVE_SOLARIS_THREADS */
#define HAVE_SRANDOM 1
/* #undef HAVE_SSL */
/* #undef HAVE_SSL_CTX_SET_ALPN_PROTOS */
/* #undef HAVE_SSL_CTX_SET_ALPN_SELECT_CB */
/* #undef HAVE_SSL_CTX_SET_CIPHERSUITES */
/* #undef HAVE_SSL_CTX_SET_SECURITY_LEVEL */
/* #undef HAVE_SSL_CTX_SET_TLSEXT_TICKET_KEY_EVP_CB */
/* #undef HAVE_SSL_GET0_ALPN_SELECTED */
/* #undef HAVE_SSL_GET0_PEERNAME */
/* #undef HAVE_SSL_GET1_PEER_CERTIFICATE */
/* #undef HAVE_SSL_SET1_HOST */
#define HAVE_STDARG_H 1
#define HAVE_STDBOOL_H 1
#define HAVE_STDINT_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRFTIME 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_STRLCAT 1
#define HAVE_STRLCPY 1
#define HAVE_STRPTIME 1
#define HAVE_STRSEP 1
#define HAVE_STRUCT_IN_PKTINFO_IPI_SPEC_DST 1
/* #undef HAVE_STRUCT_SOCKADDR_UN_SUN_LEN */
/* #undef HAVE_SWIG */
/* #undef HAVE_SYSLOG_H */
/* #undef HAVE_SYSTEMD */
/* #undef HAVE_SYS_ENDIAN_H */
#define HAVE_SYS_IPC_H 1
#define HAVE_SYS_PARAM_H 1
#define HAVE_SYS_RESOURCE_H 1
#define HAVE_SYS_SELECT_H 1
/* #undef HAVE_SYS_SHA2_H */
#define HAVE_SYS_SHM_H 1
#define HAVE_SYS_SOCKET_H 1
#define HAVE_SYS_STAT_H 1
/* #undef HAVE_SYS_SYSCTL_H */
#define HAVE_SYS_TYPES_H 1
#define HAVE_SYS_UIO_H 1
#define HAVE_SYS_UN_H 1
#define HAVE_SYS_WAIT_H 1
/* #undef HAVE_TARGETCONDITIONALS_H */
#define HAVE_TIME_H 1
#define HAVE_TZSET 1
#define HAVE_UNISTD_H 1
#define HAVE_USLEEP 1
#define HAVE_VFORK 1
/* #undef HAVE_VFORK_H */
/* #undef HAVE_WINDOWS_H */
/* #undef HAVE_WINDOWS_THREADS */
/* #undef HAVE_WINSOCK2_H */
#define HAVE_WORKING_FORK 1
#define HAVE_WORKING_VFORK 1
#define HAVE_WRITEV 1
/* #undef HAVE_WS2TCPIP_H */
/* #undef HAVE_X509_VERIFY_PARAM_SET1_HOST */
/* #undef HAVE__BEGINTHREADEX */
/* #undef HMAC_INIT_EX_RETURNS_VOID */
#define LEX_HAS_YYLEX_DESTROY 1
#define LT_OBJDIR ".libs/"
#define MAXSYSLOGMSGLEN 10240
/* #undef MEMCMP_IS_BROKEN */
/* #undef MKDIR_HAS_ONE_ARG */
/* #undef NONBLOCKING_IS_BROKEN */
/* #undef OMITTED__D_ALL_SOURCE */
/* #undef OMITTED__D_BSD_SOURCE */
/* #undef OMITTED__D_DEFAULT_SOURCE */
#define OMITTED__D_GNU_SOURCE 1
/* #undef OMITTED__D_LARGEFILE_SOURCE_1 */
/* #undef OMITTED__D_POSIX_C_SOURCE_200112 */
/* #undef OMITTED__D_XOPEN_SOURCE_600 */
/* #undef OMITTED__D_XOPEN_SOURCE_EXTENDED_1 */
/* #undef OMITTED__D__EXTENSIONS__ */
#define PACKAGE_BUGREPORT "unbound-bugs@nlnetlabs.nl or https://github.com/NLnetLabs/unbound/issues"
#define PACKAGE_NAME "unbound"
#define PACKAGE_STRING "unbound 1.14.0"
#define PACKAGE_TARNAME "unbound"
#define PACKAGE_URL ""
#define PACKAGE_VERSION "1.14.0"
#define PIDFILE ""
/* #undef PTHREAD_CREATE_JOINABLE */
#define RETSIGTYPE void
#define REUSEPORT_DEFAULT 1
#define ROOT_ANCHOR_FILE "/etc/unbound/root.key"
#define ROOT_CERT_FILE "/etc/unbound/icannbundle.pem"
#define RSRC_PACKAGE_VERSION 1,14,0,0
#define RUN_DIR "/etc/unbound"
#define SHARE_DIR "/etc/unbound"
#define SIZEOF_TIME_T 8
/* #undef SNPRINTF_RET_BROKEN */
/* #undef SODIUM_MISUSE_HANDLER */
#define STDC_HEADERS 1
#define STRPTIME_WORKS 1
/* #undef UB_ON_WINDOWS */
#define UB_SYSLOG_FACILITY LOG_DAEMON
#define UB_USERNAME "unbound"
/* #undef UNBOUND_ALLOC_LITE */
/* #undef UNBOUND_ALLOC_NONREGIONAL */
/* #undef UNBOUND_ALLOC_STATS */
/* #undef UNBOUND_DEBUG */
/* #undef USE_CACHEDB */
/* #undef USE_DNSCRYPT */
/* #undef USE_DNSCRYPT_XCHACHA20 */
/* #undef USE_DNSTAP */
/* #undef USE_DSA */
#define USE_ECDSA 1
/* #undef USE_ECDSA_EVP_WORKAROUND */
/* #undef USE_ED25519 */
/* #undef USE_ED448 */
/* #undef USE_GOST */
/* #undef USE_IPSECMOD */
/* #undef USE_IPSET */
/* #undef USE_LIBEVENT */
/* #undef USE_LINUX_IP_LOCAL_PORT_RANGE */
#define USE_MINI_EVENT 1
/* #undef USE_MSG_FASTOPEN */
/* #undef USE_OSX_MSG_FASTOPEN */
/* #undef USE_REDIS */
#define USE_SHA1 1
#define USE_SHA2 1
#define _GNU_SOURCE 1
/* #undef USE_TCP_FASTOPEN */
/* #undef USE_WINSOCK */
#define WINVER 0x0502
/* #undef WITH_DYNLIBMODULE */
/* #undef WITH_PYTHONMODULE */
/* #undef WITH_PYUNBOUND */
/* #undef YYTEXT_POINTER */
/* #undef _FILE_OFFSET_BITS */
/* #undef _LARGEFILE_SOURCE */
/* #undef _LARGE_FILES */
/* #undef _MINIX */
/* #undef _NETBSD_SOURCE */
/* #undef _POSIX_1_SOURCE */
/* #undef _POSIX_SOURCE */
/* #undef const */
/* #undef gid_t */
/* #undef in_addr_t */
/* #undef in_port_t */
#ifndef __cplusplus
/* #undef inline */
#endif
/* #undef int16_t */
/* #undef int32_t */
/* #undef int64_t */
/* #undef int8_t */
/* #undef malloc */
/* #undef off_t */
/* #undef pid_t */
/* #undef rlim_t */
/* #undef size_t */
/* #undef socklen_t */
/* #undef ssize_t */
/* #undef u_char */
/* #undef uid_t */
/* #undef uint16_t */
/* #undef uint32_t */
/* #undef uint64_t */
/* #undef uint8_t */
/* #undef vfork */
#ifndef UNBOUND_DEBUG
# ifndef NDEBUG
#  define NDEBUG
# endif
#endif
#define USE_SLDNS 1
#ifdef HAVE_SSL
#  define LDNS_BUILD_CONFIG_HAVE_SSL 1
#endif
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <assert.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdarg.h>
#include <stdint.h>
#include <errno.h>
#if HAVE_SYS_PARAM_H
#include <sys/param.h>
#endif
#include <sys/socket.h>
#include <sys/uio.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#ifdef HAVE_WINSOCK2_H
#include <winsock2.h>
#endif
#ifdef HAVE_WS2TCPIP_H
#include <ws2tcpip.h>
#endif
#ifndef USE_WINSOCK
#define ARG_LL "%ll"
#else
#define ARG_LL "%I64"
#endif
#ifdef HAVE_ATTR_FORMAT
#  define ATTR_FORMAT(archetype, string_index, first_to_check) \
    __attribute__ ((format (archetype, string_index, first_to_check)))
#else /* !HAVE_ATTR_FORMAT */
#  define ATTR_FORMAT(archetype, string_index, first_to_check) /* empty */
#endif /* !HAVE_ATTR_FORMAT */
#if defined(DOXYGEN)
#  define ATTR_UNUSED(x)  x
#elif defined(__cplusplus)
#  define ATTR_UNUSED(x)
#elif defined(HAVE_ATTR_UNUSED)
#  define ATTR_UNUSED(x)  x __attribute__((unused))
#else /* !HAVE_ATTR_UNUSED */
#  define ATTR_UNUSED(x)  x
#endif /* !HAVE_ATTR_UNUSED */
#ifndef MAXHOSTNAMELEN
#define MAXHOSTNAMELEN 256
#endif
#ifdef HAVE_WINSOCK2_H
#define FD_SET_T (u_int)
#else
#define FD_SET_T 
#endif
#ifndef IPV6_MIN_MTU
#define IPV6_MIN_MTU 1280
#endif /* IPV6_MIN_MTU */
#if defined(HAVE_EVENT_H) && !defined(HAVE_EVENT_BASE_ONCE) && !(defined(HAVE_EV_LOOP) || defined(HAVE_EV_DEFAULT_LOOP)) && (defined(HAVE_PTHREAD) || defined(HAVE_SOLARIS_THREADS))
#  define LIBEVENT_SIGNAL_PROBLEM 1
#endif
#ifndef CHECKED_INET6
#  define CHECKED_INET6
#  ifdef AF_INET6
#    define INET6
#  else
#    define AF_INET6        28
#  endif
#endif /* CHECKED_INET6 */
#define UNBOUND_DNS_PORT 53
#define UNBOUND_DNS_OVER_TLS_PORT 853
#define UNBOUND_DNS_OVER_HTTPS_PORT 443
#define UNBOUND_CONTROL_PORT 8953
#define UNBOUND_CONTROL_VERSION 1
