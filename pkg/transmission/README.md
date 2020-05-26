# transmission

## config.h

Generated with

	./configure \
		--disable-nls \
		--without-gtk \
		--without-systemd \
		LIBCURL_CFLAGS=-I/src/oasis/out/pkg/curl/include \
		LIBCURL_LIBS=/src/oasis/out/pkg/curl/libcurl.a \
		PKG_CONFIG=true

transmission doesn't create `config.h` by default, so it was created from the
defines at the end of `config.log`.
