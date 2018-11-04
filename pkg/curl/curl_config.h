/* #undef CURLDEBUG */
/* #undef CURL_CA_BUNDLE */
#define CURL_CA_FALLBACK 1
/* #undef CURL_CA_PATH */
/* #undef CURL_DEFAULT_SSL_BACKEND */
/* #undef CURL_DISABLE_COOKIES */
/* #undef CURL_DISABLE_CRYPTO_AUTH */
/* #undef CURL_DISABLE_DICT */
/* #undef CURL_DISABLE_FILE */
/* #undef CURL_DISABLE_FTP */
/* #undef CURL_DISABLE_GOPHER */
/* #undef CURL_DISABLE_HTTP */
/* #undef CURL_DISABLE_IMAP */
#define CURL_DISABLE_LDAP 1
#define CURL_DISABLE_LDAPS 1
/* #undef CURL_DISABLE_LIBCURL_OPTION */
/* #undef CURL_DISABLE_OPENSSL_AUTO_LOAD_CONFIG */
#define CURL_DISABLE_POP3 1
/* #undef CURL_DISABLE_PROXY */
/* #undef CURL_DISABLE_RTSP */
#define CURL_DISABLE_SMB 1
#define CURL_DISABLE_SMTP 1
/* #undef CURL_DISABLE_TELNET */
/* #undef CURL_DISABLE_TFTP */
/* #undef CURL_DISABLE_TLS_SRP */
/* #undef CURL_DISABLE_VERBOSE_STRINGS */
#define CURL_EXTERN_SYMBOL __attribute__ ((__visibility__ ("default")))
#define CURL_SA_FAMILY_T sa_family_t
/* #undef CURL_WITH_MULTI_SSL */
/* #undef DEBUGBUILD */
/* #undef EGD_SOCKET */
#define ENABLE_IPV6 1
#define GETHOSTNAME_TYPE_ARG2 size_t
#define GETSERVBYPORT_R_ARGS 6
#define GETSERVBYPORT_R_BUFSIZE 4096
#define HAVE_ALARM 1
#define HAVE_ALLOCA_H 1
#define HAVE_ARPA_INET_H 1
#define HAVE_ARPA_TFTP_H 1
#define HAVE_ASSERT_H 1
#define HAVE_BASENAME 1
#define HAVE_BOOL_T 1
/* #undef HAVE_BORINGSSL */
/* #undef HAVE_BROTLI */
/* #undef HAVE_BROTLI_DECODE_H */
/* #undef HAVE_BUILTIN_AVAILABLE */
#define HAVE_CLOCK_GETTIME_MONOTONIC 1
/* #undef HAVE_CLOSESOCKET */
/* #undef HAVE_CLOSESOCKET_CAMEL */
#define HAVE_CONNECT 1
/* #undef HAVE_CRYPTO_H */
/* #undef HAVE_CYASSL_CTX_USESUPPORTEDCURVE */
/* #undef HAVE_CYASSL_ERROR_SSL_H */
/* #undef HAVE_CYASSL_GET_PEER_CERTIFICATE */
/* #undef HAVE_CYASSL_OPTIONS_H */
#define HAVE_DECL_GETPWUID_R 1
/* #undef HAVE_DECL_GETPWUID_R_MISSING */
#define HAVE_DLFCN_H 1
#define HAVE_ENGINE_CLEANUP 1
#define HAVE_ERRNO_H 1
/* #undef HAVE_ERR_H */
#define HAVE_FCNTL 1
#define HAVE_FCNTL_H 1
#define HAVE_FCNTL_O_NONBLOCK 1
#define HAVE_FDOPEN 1
#define HAVE_FNMATCH 1
#define HAVE_FREEADDRINFO 1
#define HAVE_FREEIFADDRS 1
#define HAVE_FSETXATTR 1
#define HAVE_FSETXATTR_5 1
/* #undef HAVE_FSETXATTR_6 */
#define HAVE_FTRUNCATE 1
#define HAVE_GAI_STRERROR 1
#define HAVE_GETADDRINFO 1
#define HAVE_GETADDRINFO_THREADSAFE 1
#define HAVE_GETEUID 1
#define HAVE_GETHOSTBYADDR 1
#define HAVE_GETHOSTBYADDR_R 1
/* #undef HAVE_GETHOSTBYADDR_R_5 */
/* #undef HAVE_GETHOSTBYADDR_R_7 */
#define HAVE_GETHOSTBYADDR_R_8 1
#define HAVE_GETHOSTBYNAME 1
#define HAVE_GETHOSTBYNAME_R 1
/* #undef HAVE_GETHOSTBYNAME_R_3 */
/* #undef HAVE_GETHOSTBYNAME_R_5 */
#define HAVE_GETHOSTBYNAME_R_6 1
#define HAVE_GETHOSTNAME 1
#define HAVE_GETIFADDRS 1
/* #undef HAVE_GETPASS_R */
#define HAVE_GETPPID 1
#define HAVE_GETPWUID 1
#define HAVE_GETPWUID_R 1
#define HAVE_GETRLIMIT 1
#define HAVE_GETSERVBYPORT_R 1
#define HAVE_GETTIMEOFDAY 1
/* #undef HAVE_GLIBC_STRERROR_R */
#define HAVE_GMTIME_R 1
/* #undef HAVE_GNUTLS_ALPN_SET_PROTOCOLS */
/* #undef HAVE_GNUTLS_CERTIFICATE_SET_X509_KEY_FILE2 */
/* #undef HAVE_GNUTLS_OCSP_REQ_INIT */
/* #undef HAVE_GNUTLS_SRP */
/* #undef HAVE_GSSAPI */
/* #undef HAVE_GSSAPI_GSSAPI_GENERIC_H */
/* #undef HAVE_GSSAPI_GSSAPI_H */
/* #undef HAVE_GSSAPI_GSSAPI_KRB5_H */
/* #undef HAVE_GSSGNU */
/* #undef HAVE_GSSHEIMDAL */
/* #undef HAVE_GSSMIT */
/* #undef HAVE_IDN2_H */
#define HAVE_IFADDRS_H 1
#define HAVE_IF_NAMETOINDEX 1
/* #undef HAVE_INET_NTOA_R */
/* #undef HAVE_INET_NTOA_R_2 */
/* #undef HAVE_INET_NTOA_R_3 */
#define HAVE_INET_NTOP 1
#define HAVE_INET_PTON 1
#define HAVE_INTTYPES_H 1
#define HAVE_IOCTL 1
/* #undef HAVE_IOCTLSOCKET */
/* #undef HAVE_IOCTLSOCKET_CAMEL */
/* #undef HAVE_IOCTLSOCKET_CAMEL_FIONBIO */
/* #undef HAVE_IOCTLSOCKET_FIONBIO */
#define HAVE_IOCTL_FIONBIO 1
#define HAVE_IOCTL_SIOCGIFADDR 1
/* #undef HAVE_IO_H */
/* #undef HAVE_LBER_H */
/* #undef HAVE_LDAPSSL_H */
/* #undef HAVE_LDAP_H */
/* #undef HAVE_LDAP_INIT_FD */
#define HAVE_LDAP_SSL 1
/* #undef HAVE_LDAP_SSL_H */
/* #undef HAVE_LDAP_URL_PARSE */
/* #undef HAVE_LIBBROTLIDEC */
#define HAVE_LIBGEN_H 1
/* #undef HAVE_LIBIDN2 */
#define HAVE_LIBRESSL 1
/* #undef HAVE_LIBRTMP_RTMP_H */
/* #undef HAVE_LIBSSH */
/* #undef HAVE_LIBSSH2 */
/* #undef HAVE_LIBSSH2_H */
/* #undef HAVE_LIBSSH_LIBSSH_H */
#define HAVE_LIBSSL 1
#define HAVE_LIBZ 1
#define HAVE_LINUX_TCP_H 1
#define HAVE_LL 1
#define HAVE_LOCALE_H 1
#define HAVE_LOCALTIME_R 1
#define HAVE_LONGLONG 1
/* #undef HAVE_MACH_ABSOLUTE_TIME */
#define HAVE_MALLOC_H 1
#define HAVE_MEMORY_H 1
/* #undef HAVE_MEMRCHR */
#define HAVE_MSG_NOSIGNAL 1
#define HAVE_NETDB_H 1
/* #undef HAVE_NETINET_IN6_H */
#define HAVE_NETINET_IN_H 1
#define HAVE_NETINET_TCP_H 1
#define HAVE_NET_IF_H 1
/* #undef HAVE_NGHTTP2_NGHTTP2_H */
/* #undef HAVE_OLD_GSSMIT */
#define HAVE_OPENSSL_CRYPTO_H 1
#define HAVE_OPENSSL_ERR_H 1
#define HAVE_OPENSSL_PEM_H 1
#define HAVE_OPENSSL_RSA_H 1
/* #undef HAVE_OPENSSL_SRP */
#define HAVE_OPENSSL_SSL_H 1
#define HAVE_OPENSSL_X509_H 1
/* #undef HAVE_PEM_H */
#define HAVE_PIPE 1
/* #undef HAVE_PK11_CREATEMANAGEDGENERICOBJECT */
#define HAVE_POLL 1
#define HAVE_POLL_FINE 1
#define HAVE_POLL_H 1
#define HAVE_POSIX_STRERROR_R 1
#define HAVE_PTHREAD_H 1
#define HAVE_PWD_H 1
/* #undef HAVE_RAND_EGD */
#define HAVE_RECV 1
/* #undef HAVE_RSA_H */
#define HAVE_SELECT 1
#define HAVE_SEND 1
#define HAVE_SETJMP_H 1
#define HAVE_SETLOCALE 1
/* #undef HAVE_SETMODE */
#define HAVE_SETRLIMIT 1
#define HAVE_SETSOCKOPT 1
/* #undef HAVE_SETSOCKOPT_SO_NONBLOCK */
/* #undef HAVE_SGTTY_H */
#define HAVE_SIGACTION 1
#define HAVE_SIGINTERRUPT 1
#define HAVE_SIGNAL 1
#define HAVE_SIGNAL_H 1
#define HAVE_SIGSETJMP 1
#define HAVE_SIG_ATOMIC_T 1
/* #undef HAVE_SIG_ATOMIC_T_VOLATILE */
#define HAVE_SOCKADDR_IN6_SIN6_SCOPE_ID 1
#define HAVE_SOCKET 1
#define HAVE_SOCKETPAIR 1
/* #undef HAVE_SOCKET_H */
/* #undef HAVE_SSLV2_CLIENT_METHOD */
#define HAVE_SSL_GET_SHUTDOWN 1
/* #undef HAVE_SSL_H */
#define HAVE_STDBOOL_H 1
#define HAVE_STDINT_H 1
#define HAVE_STDIO_H 1
#define HAVE_STDLIB_H 1
#define HAVE_STRCASECMP 1
/* #undef HAVE_STRCMPI */
#define HAVE_STRDUP 1
#define HAVE_STRERROR_R 1
/* #undef HAVE_STRICMP */
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_STRNCASECMP 1
/* #undef HAVE_STRNCMPI */
/* #undef HAVE_STRNICMP */
#define HAVE_STROPTS_H 1
#define HAVE_STRSTR 1
#define HAVE_STRTOK_R 1
#define HAVE_STRTOLL 1
#define HAVE_STRUCT_SOCKADDR_STORAGE 1
#define HAVE_STRUCT_TIMEVAL 1
/* #undef HAVE_SYS_FILIO_H */
#define HAVE_SYS_IOCTL_H 1
#define HAVE_SYS_PARAM_H 1
#define HAVE_SYS_POLL_H 1
#define HAVE_SYS_RESOURCE_H 1
#define HAVE_SYS_SELECT_H 1
#define HAVE_SYS_SOCKET_H 1
/* #undef HAVE_SYS_SOCKIO_H */
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_TIME_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_SYS_UIO_H 1
#define HAVE_SYS_UN_H 1
/* #undef HAVE_SYS_UTIME_H */
#define HAVE_SYS_WAIT_H 1
#define HAVE_SYS_XATTR_H 1
#define HAVE_TERMIOS_H 1
/* #undef HAVE_TERMIO_H */
#define HAVE_TIME_H 1
/* #undef HAVE_TIME_T_UNSIGNED */
#define HAVE_UNISTD_H 1
#define HAVE_UTIME 1
#define HAVE_UTIMES 1
#define HAVE_UTIME_H 1
#define HAVE_VARIADIC_MACROS_C99 1
#define HAVE_VARIADIC_MACROS_GCC 1
/* #undef HAVE_WINBER_H */
/* #undef HAVE_WINDOWS_H */
/* #undef HAVE_WINLDAP_H */
/* #undef HAVE_WINSOCK2_H */
/* #undef HAVE_WINSOCK_H */
/* #undef HAVE_WOLFSSLV3_CLIENT_METHOD */
/* #undef HAVE_WOLFSSL_CTX_USESUPPORTEDCURVE */
/* #undef HAVE_WOLFSSL_GET_PEER_CERTIFICATE */
/* #undef HAVE_WOLFSSL_USEALPN */
/* #undef HAVE_WRITABLE_ARGV */
#define HAVE_WRITEV 1
/* #undef HAVE_WS2TCPIP_H */
/* #undef HAVE_X509_H */
#define HAVE_ZLIB_H 1
#define LT_OBJDIR ".libs/"
/* #undef NEED_LBER_H */
/* #undef NEED_MALLOC_H */
/* #undef NEED_MEMORY_H */
/* #undef NEED_REENTRANT */
/* #undef NEED_THREAD_SAFE */
#define NTLM_WB_ENABLED 1
#define NTLM_WB_FILE "/usr/bin/ntlm_auth"
#define OS "oasis"
#define PACKAGE "curl"
#define PACKAGE_BUGREPORT "a suitable curl mailing list: https://curl.haxx.se/mail/"
#define PACKAGE_NAME "curl"
#define PACKAGE_STRING "curl -"
#define PACKAGE_TARNAME "curl"
#define PACKAGE_URL ""
#define PACKAGE_VERSION "-"
#define RANDOM_FILE "/dev/urandom"
#define RECV_TYPE_ARG1 int
#define RECV_TYPE_ARG2 void *
#define RECV_TYPE_ARG3 size_t
#define RECV_TYPE_ARG4 int
#define RECV_TYPE_RETV ssize_t
#define RETSIGTYPE void
#define SELECT_QUAL_ARG5 
#define SELECT_TYPE_ARG1 int
#define SELECT_TYPE_ARG234 fd_set *
#define SELECT_TYPE_ARG5 struct timeval *
#define SELECT_TYPE_RETV int
#define SEND_QUAL_ARG2 const
#define SEND_TYPE_ARG1 int
#define SEND_TYPE_ARG2 void *
#define SEND_TYPE_ARG3 size_t
#define SEND_TYPE_ARG4 int
#define SEND_TYPE_RETV ssize_t
#define SIZEOF_CURL_OFF_T 8
#define SIZEOF_INT 4
/* probe SIZEOF_LONG */
/* #undef SIZEOF_LONG_LONG */
#define SIZEOF_OFF_T 8
#define SIZEOF_SHORT 2
/* probe SIZEOF_SIZE_T */
/* probe SIZEOF_TIME_T */
#define STDC_HEADERS 1
#define STRERROR_R_TYPE_ARG3 size_t
#define TIME_WITH_SYS_TIME 1
/* #undef USE_ARES */
/* #undef USE_AXTLS */
/* #undef USE_CYASSL */
/* #undef USE_DARWINSSL */
/* #undef USE_GNUTLS */
/* #undef USE_GNUTLS_NETTLE */
/* #undef USE_LIBPSL */
/* #undef USE_LIBRTMP */
/* #undef USE_LIBSSH */
/* #undef USE_LIBSSH2 */
/* #undef USE_MANUAL */
/* #undef USE_MBEDTLS */
/* #undef USE_MESALINK */
/* #undef USE_METALINK */
/* #undef USE_NGHTTP2 */
/* #undef USE_NSS */
/* #undef USE_OPENLDAP */
#define USE_OPENSSL 1
/* #undef USE_POLARSSL */
/* #undef USE_SCHANNEL */
#define USE_THREADS_POSIX 1
/* #undef USE_THREADS_WIN32 */
/* #undef USE_TLS_SRP */
#define USE_UNIX_SOCKETS 1
/* #undef USE_WIN32_IDN */
/* #undef USE_WIN32_LARGE_FILES */
/* #undef USE_WIN32_LDAP */
/* #undef USE_WIN32_SMALL_FILES */
/* #undef USE_WINDOWS_SSPI */
#define VERSION "-"
/* #undef WANT_IDN_PROTOTYPES */
#ifndef _ALL_SOURCE
/* #  undef _ALL_SOURCE */
#endif
#ifndef _DARWIN_USE_64_BIT_INODE
# define _DARWIN_USE_64_BIT_INODE 1
#endif
/* #undef _FILE_OFFSET_BITS */
/* #undef _LARGE_FILES */
/* #undef const */
/* #undef in_addr_t */
#ifndef __cplusplus
/* #undef inline */
#endif
/* #undef size_t */
/* #undef ssize_t */
