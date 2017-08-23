# curl

## curl_config.h
Generated with

	./configure \
		--disable-pop3 \
		--disable-smb \
		--disable-smtp \
		--with-ca-fallback \
		--without-ca-bundle \
		CPPFLAGS='-I/src/oasis/out/pkg/libressl/include -I/src/oasis/out/pkg/zlib/include' \
		LDFLAGS='-L/src/oasis/out/pkg/libressl -L/src/oasis/out/pkg/zlib/lib' \
		LIBS=/src/oasis/out/pkg/openbsd/libbsd.a

There are a number of non-standard definitions, but they don't seem to be
architecture-specific except for

- `SIZEOF_INT`
- `SIZEOF_LONG`
- `SIZEOF_LONG_LONG`
- `SIZEOF_OFF_T`
- `SIZEOF_SHORT`
- `SIZEOF_TIME_T`
- `SIZEOF_VOIDP`

Perhaps all or most of these can eliminated using standard C99 features.
