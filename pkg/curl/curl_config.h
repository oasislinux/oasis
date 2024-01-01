/* #undef CURLDEBUG */
#define CURL_CA_BUNDLE "/etc/ssl/cert.pem"
/* #undef CURL_CA_FALLBACK */
/* #undef CURL_CA_PATH */
/* #undef CURL_DEFAULT_SSL_BACKEND */
/* #undef CURL_DISABLE_ALTSVC */
/* #undef CURL_DISABLE_AWS */
/* #undef CURL_DISABLE_BASIC_AUTH */
/* #undef CURL_DISABLE_BEARER_AUTH */
/* #undef CURL_DISABLE_BINDLOCAL */
/* #undef CURL_DISABLE_COOKIES */
/* #undef CURL_DISABLE_DICT */
/* #undef CURL_DISABLE_DIGEST_AUTH */
/* #undef CURL_DISABLE_DOH */
/* #undef CURL_DISABLE_FILE */
/* #undef CURL_DISABLE_FORM_API */
/* #undef CURL_DISABLE_FTP */
/* #undef CURL_DISABLE_GETOPTIONS */
/* #undef CURL_DISABLE_GOPHER */
/* #undef CURL_DISABLE_HEADERS_API */
/* #undef CURL_DISABLE_HSTS */
/* #undef CURL_DISABLE_HTTP */
/* #undef CURL_DISABLE_HTTP_AUTH */
/* #undef CURL_DISABLE_IMAP */
/* #undef CURL_DISABLE_KERBEROS_AUTH */
#define CURL_DISABLE_LDAP 1
#define CURL_DISABLE_LDAPS 1
/* #undef CURL_DISABLE_LIBCURL_OPTION */
/* #undef CURL_DISABLE_MIME */
/* #undef CURL_DISABLE_MQTT */
/* #undef CURL_DISABLE_NEGOTIATE_AUTH */
/* #undef CURL_DISABLE_NETRC */
/* #undef CURL_DISABLE_NTLM */
/* #undef CURL_DISABLE_OPENSSL_AUTO_LOAD_CONFIG */
/* #undef CURL_DISABLE_PARSEDATE */
#define CURL_DISABLE_POP3 1
/* #undef CURL_DISABLE_PROGRESS_METER */
/* #undef CURL_DISABLE_PROXY */
/* #undef CURL_DISABLE_RTSP */
/* #undef CURL_DISABLE_SHUFFLE_DNS */
#define CURL_DISABLE_SMB 1
/* #undef CURL_DISABLE_SMTP */
/* #undef CURL_DISABLE_SOCKETPAIR */
/* #undef CURL_DISABLE_TELNET */
/* #undef CURL_DISABLE_TFTP */
/* #undef CURL_DISABLE_VERBOSE_STRINGS */
#define CURL_EXTERN_SYMBOL __attribute__ ((__visibility__ ("default")))
#define CURL_SA_FAMILY_T sa_family_t
/* #undef CURL_WITH_MULTI_SSL */
/* #undef DEBUGBUILD */
#define ENABLE_IPV6 1
#define GETHOSTNAME_TYPE_ARG2 size_t
#define HAVE_ALARM 1
/* #undef HAVE_ARC4RANDOM */
#define HAVE_ARPA_INET_H 1
#define HAVE_ATOMIC 1
#define HAVE_BASENAME 1
#define HAVE_BOOL_T 1
/* #undef HAVE_BROTLI */
/* #undef HAVE_BROTLI_DECODE_H */
/* #undef HAVE_BUILTIN_AVAILABLE */
#define HAVE_CLOCK_GETTIME_MONOTONIC 1
#define HAVE_CLOCK_GETTIME_MONOTONIC_RAW 1
/* #undef HAVE_CLOSESOCKET */
/* #undef HAVE_CLOSESOCKET_CAMEL */
/* #undef HAVE_CRYPTO_H */
#define HAVE_DECL_FSEEKO 1
#define HAVE_DECL_GETPWUID_R 1
/* #undef HAVE_DECL_GETPWUID_R_MISSING */
#define HAVE_DLFCN_H 1
/* #undef HAVE_ERR_H */
#define HAVE_FCNTL 1
#define HAVE_FCNTL_H 1
#define HAVE_FCNTL_O_NONBLOCK 1
#define HAVE_FNMATCH 1
#define HAVE_FREEADDRINFO 1
#define HAVE_FSEEKO 1
#define HAVE_FSETXATTR 1
#define HAVE_FSETXATTR_5 1
/* #undef HAVE_FSETXATTR_6 */
#define HAVE_FTRUNCATE 1
#define HAVE_GETADDRINFO 1
#define HAVE_GETADDRINFO_THREADSAFE 1
#define HAVE_GETEUID 1
#define HAVE_GETHOSTBYNAME 1
#define HAVE_GETHOSTBYNAME_R 1
/* #undef HAVE_GETHOSTBYNAME_R_3 */
/* #undef HAVE_GETHOSTBYNAME_R_5 */
#define HAVE_GETHOSTBYNAME_R_6 1
#define HAVE_GETHOSTNAME 1
#define HAVE_GETIFADDRS 1
/* #undef HAVE_GETPASS_R */
#define HAVE_GETPEERNAME 1
#define HAVE_GETPPID 1
#define HAVE_GETPWUID 1
#define HAVE_GETPWUID_R 1
#define HAVE_GETRLIMIT 1
#define HAVE_GETSOCKNAME 1
#define HAVE_GETTIMEOFDAY 1
/* #undef HAVE_GLIBC_STRERROR_R */
#define HAVE_GMTIME_R 1
/* #undef HAVE_GNUTLS_SRP */
/* #undef HAVE_GSSAPI */
/* #undef HAVE_GSSAPI_GSSAPI_GENERIC_H */
/* #undef HAVE_GSSAPI_GSSAPI_H */
/* #undef HAVE_GSSAPI_GSSAPI_KRB5_H */
/* #undef HAVE_GSSGNU */
/* #undef HAVE_GSSHEIMDAL */
/* #undef HAVE_GSSMIT */
/* #undef HAVE_HYPER_H */
/* #undef HAVE_IDN2_H */
#define HAVE_IFADDRS_H 1
#define HAVE_IF_NAMETOINDEX 1
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
/* #undef HAVE_LDAP_H */
/* #undef HAVE_LDAP_INIT_FD */
#define HAVE_LDAP_SSL 1
/* #undef HAVE_LDAP_SSL_H */
/* #undef HAVE_LDAP_URL_PARSE */
/* #undef HAVE_LIBBROTLIDEC */
#define HAVE_LIBGEN_H 1
/* #undef HAVE_LIBIDN2 */
/* #undef HAVE_LIBRESSL */
/* #undef HAVE_LIBRTMP_RTMP_H */
/* #undef HAVE_LIBSSH */
/* #undef HAVE_LIBSSH2 */
/* #undef HAVE_LIBSSL */
/* #undef HAVE_LIBWOLFSSH */
#define HAVE_LIBZ 1
/* #undef HAVE_LIBZSTD */
#define HAVE_LINUX_TCP_H 1
#define HAVE_LOCALE_H 1
#define HAVE_LONGLONG 1
/* #undef HAVE_MACH_ABSOLUTE_TIME */
/* #undef HAVE_MEMRCHR */
#define HAVE_MSG_NOSIGNAL 1
/* #undef HAVE_MSH3_H */
#define HAVE_NETDB_H 1
/* #undef HAVE_NETINET_IN6_H */
#define HAVE_NETINET_IN_H 1
#define HAVE_NETINET_TCP_H 1
#define HAVE_NETINET_UDP_H 1
#define HAVE_NET_IF_H 1
/* #undef HAVE_NGHTTP2_NGHTTP2_H */
/* #undef HAVE_NGHTTP3_NGHTTP3_H */
/* #undef HAVE_NGTCP2_NGTCP2_CRYPTO_H */
/* #undef HAVE_NGTCP2_NGTCP2_H */
/* #undef HAVE_OLD_GSSMIT */
/* #undef HAVE_OPENSSL3 */
/* #undef HAVE_OPENSSL_CRYPTO_H */
/* #undef HAVE_OPENSSL_ERR_H */
/* #undef HAVE_OPENSSL_PEM_H */
/* #undef HAVE_OPENSSL_RSA_H */
/* #undef HAVE_OPENSSL_SRP */
/* #undef HAVE_OPENSSL_SSL_H */
/* #undef HAVE_OPENSSL_X509_H */
/* #undef HAVE_PEM_H */
#define HAVE_PIPE 1
#define HAVE_POLL_FINE 1
#define HAVE_POLL_H 1
#define HAVE_POSIX_STRERROR_R 1
/* #undef HAVE_PROTO_BSDSOCKET_H */
#define HAVE_PTHREAD_H 1
#define HAVE_PWD_H 1
/* #undef HAVE_QUICHE_CONN_SET_QLOG_FD */
/* #undef HAVE_QUICHE_H */
#define HAVE_RECV 1
/* #undef HAVE_RSA_H */
#define HAVE_SCHED_YIELD 1
#define HAVE_SELECT 1
#define HAVE_SEND 1
#define HAVE_SENDMSG 1
#define HAVE_SETJMP_H 1
#define HAVE_SETLOCALE 1
/* #undef HAVE_SETMODE */
#define HAVE_SETRLIMIT 1
#define HAVE_SIGACTION 1
#define HAVE_SIGINTERRUPT 1
#define HAVE_SIGNAL 1
#define HAVE_SIGSETJMP 1
#define HAVE_SNPRINTF 1
#define HAVE_SOCKADDR_IN6_SIN6_SCOPE_ID 1
#define HAVE_SOCKET 1
#define HAVE_SOCKETPAIR 1
/* #undef HAVE_SOCKET_H */
/* #undef HAVE_SSL_GET_ECH_STATUS */
/* #undef HAVE_SSL_H */
/* #undef HAVE_SSL_SET0_WBIO */
#define HAVE_STDATOMIC_H 1
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
#define HAVE_STROPTS_H 1
#define HAVE_STRTOK_R 1
#define HAVE_STRTOLL 1
#define HAVE_STRUCT_SOCKADDR_STORAGE 1
#define HAVE_STRUCT_TIMEVAL 1
#define HAVE_SUSECONDS_T 1
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
#define HAVE_SYS_UN_H 1
/* #undef HAVE_SYS_UTIME_H */
#define HAVE_SYS_WAIT_H 1
#define HAVE_SYS_XATTR_H 1
#define HAVE_TERMIOS_H 1
/* #undef HAVE_TERMIO_H */
/* #undef HAVE_TIME_T_UNSIGNED */
#define HAVE_UNISTD_H 1
#define HAVE_UTIME 1
#define HAVE_UTIMES 1
#define HAVE_UTIME_H 1
/* #undef HAVE_WINDOWS_H */
/* #undef HAVE_WINSOCK2_H */
/* #undef HAVE_WOLFSSH_SSH_H */
/* #undef HAVE_WOLFSSL_DES_ECB_ENCRYPT */
/* #undef HAVE_WOLFSSL_FULL_BIO */
/* #undef HAVE_WOLFSSL_GET_PEER_CERTIFICATE */
/* #undef HAVE_WOLFSSL_USEALPN */
#define HAVE_WRITABLE_ARGV 1
/* #undef HAVE_WS2TCPIP_H */
/* #undef HAVE_X509_H */
/* #undef HAVE_ZSTD */
/* #undef HAVE_ZSTD_H */
/* #undef HAVE__FSEEKI64 */
#define LT_OBJDIR ".libs/"
/* #undef NEED_LBER_H */
/* #undef NEED_REENTRANT */
/* #undef NEED_THREAD_SAFE */
/* #undef NTLM_WB_ENABLED */
/* #undef NTLM_WB_FILE */
#define OS "oasis"
#define PACKAGE "curl"
#define PACKAGE_BUGREPORT "a suitable curl mailing list: https://curl.se/mail/"
#define PACKAGE_NAME "curl"
#define PACKAGE_STRING "curl -"
#define PACKAGE_TARNAME "curl"
#define PACKAGE_URL ""
#define PACKAGE_VERSION "-"
/* #undef RANDOM_FILE */
#define SIZEOF_CURL_OFF_T 8
#define SIZEOF_CURL_SOCKET_T 4
#define SIZEOF_INT 4
/* probe SIZEOF_LONG */
/* #undef SIZEOF_LONG_LONG */
#define SIZEOF_OFF_T 8
/* probe SIZEOF_SIZE_T */
/* probe SIZEOF_TIME_T */
#define STDC_HEADERS 1
/* #undef USE_AMISSL */
/* #undef USE_ARES */
#define USE_BEARSSL 1
/* #undef USE_ECH */
/* #undef USE_GNUTLS */
/* #undef USE_GSASL */
/* #undef USE_HYPER */
/* #undef USE_LIBPSL */
/* #undef USE_LIBRTMP */
/* #undef USE_LIBSSH */
/* #undef USE_LIBSSH2 */
/* #undef USE_MANUAL */
/* #undef USE_MBEDTLS */
/* #undef USE_MSH3 */
/* #undef USE_NGHTTP2 */
/* #undef USE_NGHTTP3 */
/* #undef USE_NGTCP2 */
/* #undef USE_NGTCP2_CRYPTO_GNUTLS */
/* #undef USE_NGTCP2_CRYPTO_QUICTLS */
/* #undef USE_NGTCP2_CRYPTO_WOLFSSL */
/* #undef USE_OPENLDAP */
/* #undef USE_OPENSSL */
/* #undef USE_QUICHE */
/* #undef USE_RUSTLS */
/* #undef USE_SCHANNEL */
/* #undef USE_SECTRANSP */
#define USE_THREADS_POSIX 1
/* #undef USE_THREADS_WIN32 */
/* #undef USE_TLS_SRP */
#define USE_UNIX_SOCKETS 1
/* #undef USE_WEBSOCKETS */
/* #undef USE_WIN32_CRYPTO */
/* #undef USE_WIN32_IDN */
/* #undef USE_WIN32_LARGE_FILES */
/* #undef USE_WIN32_LDAP */
/* #undef USE_WIN32_SMALL_FILES */
/* #undef USE_WINDOWS_SSPI */
/* #undef USE_WOLFSSH */
/* #undef USE_WOLFSSL */
#define VERSION "-"
#ifndef _ALL_SOURCE
/* #  undef _ALL_SOURCE */
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
