#include <config-posix.h>

/* features */
#define CURL_CA_FALLBACK 1
#define CURL_DISABLE_LDAP 1
#define CURL_DISABLE_LDAPS 1
#define CURL_DISABLE_POP3 1
#define CURL_DISABLE_RTMP 1
#define CURL_DISABLE_SMB 1
#define CURL_DISABLE_SMTP 1
#define ENABLE_IPV6 1
#define HAVE_LIBSSL 1
#define HAVE_LIBZ 1
#define HAVE_ZLIB_H 1
#define USE_OPENSSL 1
#define USE_UNIX_SOCKETS 1
/* #undef CURL_CA_BUNDLE "/etc/ssl/cert.pem" */
/* #undef CURL_CA_PATH */
/* #undef CURL_DISABLE_COOKIES */
/* #undef CURL_DISABLE_CRYPTO_AUTH */
/* #undef CURL_DISABLE_DICT */
/* #undef CURL_DISABLE_FILE */
/* #undef CURL_DISABLE_FTP */
/* #undef CURL_DISABLE_GOPHER */
/* #undef CURL_DISABLE_HTTP */
/* #undef CURL_DISABLE_IMAP */
/* #undef CURL_DISABLE_PROXY */
/* #undef CURL_DISABLE_RTSP */
/* #undef CURL_DISABLE_TELNET */
/* #undef CURL_DISABLE_TFTP */
/* #undef CURL_DISABLE_VERBOSE_STRINGS */
/* #undef DISABLED_THREADSAFE */
/* #undef EGD_SOCKET */
/* #undef HAVE_KRB4 */
/* #undef HAVE_LDAP_SSL */
/* #undef HAVE_LIBIDN */
/* #undef HAVE_LIBRESOLV */
/* #undef HAVE_LIBRESOLVE */
/* #undef HAVE_LIBSOCKET */
/* #undef HAVE_OLD_GSSMIT */
/* #undef USE_ARES */
/* #undef USE_BLOCKING_SOCKETS */
/* #undef USE_DARWINSSL */
/* #undef USE_GNUTLS */
/* #undef USE_LIBSSH2 */
/* #undef USE_MANUAL */
/* #undef USE_MBEDTLS */
/* #undef USE_NGHTTP2 */
/* #undef USE_NSS */
/* #undef USE_OPENLDAP */
/* #undef USE_POLARSSL */
/* #undef USE_SCHANNEL */
/* #undef USE_THREADS_POSIX */
/* #undef USE_THREADS_WIN32 */
/* #undef USE_WIN32_LARGE_FILES */
/* #undef USE_WIN32_LDAP */
/* #undef USE_WINDOWS_SSPI */
/* #undef USE_YASSLEMUL */

/* headers */
#define HAVE_ALLOCA_H 1
#define HAVE_ARPA_TFTP_H 1
#define HAVE_ERR_H 1
#define HAVE_IFADDRS_H 1
#define HAVE_MALLOC_H 1
#define HAVE_MEMORY_H 1
#define HAVE_OPENSSL_CRYPTO_H 1
#define HAVE_OPENSSL_ENGINE_H 1
#define HAVE_OPENSSL_ERR_H 1
#define HAVE_OPENSSL_PEM_H 1
#define HAVE_OPENSSL_PKCS12_H 1
#define HAVE_OPENSSL_RSA_H 1
#define HAVE_OPENSSL_SSL_H 1
#define HAVE_OPENSSL_X509_H 1
#define HAVE_SYS_IOCTL_H 1
#define HAVE_SYS_PARAM_H 1
#define TIME_WITH_SYS_TIME 1
/* #undef HAVE_CRYPTO_H */
/* #undef HAVE_DES_H */
/* #undef HAVE_GSSAPI_GSSAPI_GENERIC_H */
/* #undef HAVE_GSSAPI_GSSAPI_H */
/* #undef HAVE_GSSAPI_GSSAPI_KRB5_H */
/* #undef HAVE_IDN_FREE_H */
/* #undef HAVE_IO_H */
/* #undef HAVE_KRB_H */
/* #undef HAVE_LBER_H */
/* #undef HAVE_LDAP_H */
/* #undef HAVE_LDAP_SSL_H */
/* #undef HAVE_LDAPSSL_H */
/* #undef HAVE_PEM_H */
/* #undef HAVE_PROCESS_H */
/* #undef HAVE_RSA_H */
/* #undef HAVE_SGTTY_H */
/* #undef HAVE_SSL_H */
/* #undef HAVE_SYS_FILIO_H */
/* #undef HAVE_SYS_SOCKIO_H */
/* #undef HAVE_TLD_H */
/* #undef HAVE_WINBER_H */
/* #undef HAVE_WINDOWS_H */
/* #undef HAVE_WINLDAP_H */
/* #undef HAVE_WINSOCK2_H */
/* #undef HAVE_WINSOCK_H */
/* #undef HAVE_WS2TCPIP_H */
/* #undef HAVE_X509_H */
/* #undef NEED_LBER_H */

/* types */
#define SIZEOF_INT 4
#define SIZEOF_LONG 8
#define SIZEOF_OFF_T 8
#define SIZEOF_SHORT 2
#define SIZEOF_SIZE_T 8
#define SIZEOF_TIME_T 8
#define SIZEOF_VOIDP 8

/* functions */
#define GETSERVBYPORT_R_ARGS 6
#define GETSERVBYPORT_R_BUFSIZE 4096
#define HAVE_CLOCK_GETTIME_MONOTONIC 1
#define HAVE_CRYPTO_CLEANUP_ALL_EX_DATA 1
#define HAVE_ENGINE_LOAD_BUILTIN_ENGINES 1
#define HAVE_FREEIFADDRS 1
#define HAVE_FSETXATTR 1
#define HAVE_FSETXATTR_5 1
#define HAVE_GETHOSTBYADDR 1
#define HAVE_GETHOSTBYADDR_R 1
#define HAVE_GETHOSTBYADDR_R_8 1
#define HAVE_GETHOSTBYNAME 1
#define HAVE_GETHOSTBYNAME_R 1
#define HAVE_GETHOSTBYNAME_R_6 1
#define HAVE_GETIFADDRS 1
#define HAVE_GETSERVBYPORT_R 1
#define HAVE_POLL_FINE 1
#define HAVE_RAND_STATUS 1
#define HAVE_SSL_GET_SHUTDOWN 1
#define HAVE_STRCASESTR 1
#define HAVE_STRLCAT 1
#define HAVE_STRLCPY 1
/* #undef HAVE_CLOSESOCKET */
/* #undef HAVE_FSETXATTR_6 */
/* #undef HAVE_GETHOSTBYADDR_R_5 */
/* #undef HAVE_GETHOSTBYADDR_R_7 */
/* #undef HAVE_GETHOSTBYNAME_R_3 */
/* #undef HAVE_GETHOSTBYNAME_R_5 */
/* #undef HAVE_GETPASS_R */
/* #undef HAVE_GLIBC_STRERROR_R */
/* #undef HAVE_GSSAPI */
/* #undef HAVE_GSSGNU */
/* #undef HAVE_GSSHEIMDAL */
/* #undef HAVE_GSSMIT */
/* #undef HAVE_IDNA_STRERROR */
/* #undef HAVE_IDN_FREE */
/* #undef HAVE_INET_ADDR */
/* #undef HAVE_INET_NTOA_R */
/* #undef HAVE_INET_NTOA_R_2 */
/* #undef HAVE_INET_NTOA_R_3 */
/* #undef HAVE_IOCTL_FIONBIO */
/* #undef HAVE_IOCTL_SIOCGIFADDR */
/* #undef HAVE_IOCTLSOCKET */
/* #undef HAVE_IOCTLSOCKET_CAMEL */
/* #undef HAVE_IOCTLSOCKET_CAMEL_FIONBIO */
/* #undef HAVE_IOCTLSOCKET_FIONBIO */
/* #undef HAVE_KRB_GET_OUR_IP_FOR_REALM */
/* #undef HAVE_LDAP_URL_PARSE */
/* #undef HAVE_RAND_EGD */
/* #undef HAVE_RAND_SCREEN */
/* #undef HAVE_SETMODE */
/* #undef HAVE_SETSOCKOPT_SO_NONBLOCK */
/* #undef HAVE_STRCMPI */
/* #undef HAVE_STRICMP */
/* #undef HAVE_STRNCMPI */
/* #undef HAVE_STRNICMP */
/* #undef HAVE_TLD_STRERROR */

/* libssh2 */
/* undef HAVE_LIBSSH2 */
/* undef HAVE_LIBSSH2_EXIT */
/* undef HAVE_LIBSSH2_H */
/* undef HAVE_LIBSSH2_INIT */
/* undef HAVE_LIBSSH2_SCP_SEND64 */
/* undef HAVE_LIBSSH2_SESSION_HANDSHAKE */
/* undef HAVE_LIBSSH2_VERSION */

/* misc */
#define BUILDING_LIBCURL 1
#define CURL_STATICLIB 1
#define HAVE_MSG_NOSIGNAL 1
#define HAVE_VARIADIC_MACROS_GCC 1
#define OS "Linux"
#define RANDOM_FILE "/dev/urandom"
/* #undef CURL_EXTERN_SYMBOL */
/* #undef _FILE_OFFSET_BITS */
/* #undef HAVE_NI_WITHSCOPEID */
/* #undef _LARGE_FILES */
/* #undef LT_OBJDIR */
/* #undef NEED_REENTRANT */
/* #undef PACKAGE */
/* #undef PACKAGE_BUGREPORT */
/* #undef PACKAGE_NAME */
/* #undef PACKAGE_STRING */
/* #undef PACKAGE_TARNAME */
/* #undef PACKAGE_VERSION */
/* #undef _THREAD_SAFE */
/* #undef VERSION */

/* posix */
#define GETNAMEINFO_QUAL_ARG1 const
#define GETNAMEINFO_TYPE_ARG1 struct sockaddr *restrict
#define GETNAMEINFO_TYPE_ARG46 socklen_t
#define GETNAMEINFO_TYPE_ARG7 int
#define HAVE_BOOL_T 1 /* non-standard macro name? */
#define HAVE_FCNTL_O_NONBLOCK 1
#define HAVE_LL 1
#define HAVE_POSIX_STRERROR_R 1
#define HAVE_SIG_ATOMIC_T_VOLATILE 1
#define HAVE_SOCKADDR_IN6_SIN6_SCOPE_ID 1
#define HAVE_VARIADIC_MACROS_C99 1
#define HAVE_WRITABLE_ARGV 1
#define RECVFROM_TYPE_ARG1 int
#define RECVFROM_TYPE_ARG2 void *restrict
#define RECVFROM_TYPE_ARG3 size_t
#define RECVFROM_TYPE_ARG4 int
#define RECVFROM_TYPE_ARG5 struct sockaddr *restrict
#define RECVFROM_TYPE_ARG6 socklen_t *restrict
#define RECV_TYPE_ARG1 int
#define RECV_TYPE_ARG2 void *
#define RECV_TYPE_ARG3 size_t
#define RECV_TYPE_ARG4 int
#define RECV_TYPE_RETV ssize_t
#define RETSIGTYPE void
#define SELECT_QUAL_ARG5
#define SELECT_TYPE_ARG1 int
#define SELECT_TYPE_ARG234 fd_set *
#define SELECT_TYPE_ARG5 struct timeval *restrict
#define SELECT_TYPE_RETV int
#define SEND_QUAL_ARG2 const
#define SEND_TYPE_ARG1 int
#define SEND_TYPE_ARG2 void *
#define SEND_TYPE_ARG3 size_t
#define SEND_TYPE_ARG4 int
#define SEND_TYPE_RETV ssize_t
#define STRERROR_R_TYPE_ARG3 size_t
/* #undef NEED_BASENAME_PROTO */
/* #undef NEED_MALLOC_H */
/* #undef RECVFROM_TYPE_ARG2_IS_VOID */
/* #undef RECVFROM_TYPE_ARG5_IS_VOID */
/* #undef RECVFROM_TYPE_ARG6_IS_VOID  */
