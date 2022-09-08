# curl

## curl_config.h
Generated with

	./configure \
		--disable-pop3 \
		--disable-smb \
		--with-ca-bundle=/etc/ssl/cert.pem \
		--with-bearssl \
		CPPFLAGS='-I/src/oasis/out/pkg/bearssl/include -I/src/oasis/out/pkg/zlib/include' \
		LDFLAGS='-L/src/oasis/out/pkg/bearssl -L/src/oasis/out/pkg/zlib'

There are a number of non-standard definitions, but they don't seem to be
architecture-specific except for

- `SIZEOF_CURL_OFF_T`
- `SIZEOF_INT`
- `SIZEOF_LONG`
- `SIZEOF_LONG_LONG`
- `SIZEOF_OFF_T`
- `SIZEOF_SHORT`
- `SIZEOF_SIZE_T`
- `SIZEOF_TIME_T`

Perhaps all or most of these can eliminated using standard C99 features.
