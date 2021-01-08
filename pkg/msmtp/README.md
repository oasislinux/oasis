# msmtp

## config.h
Generated with

	./configure \
		--disable-nls \
		--without-libidn \
		--with-tls=libtls \
		LDFLAGS='-L/src/oasis/out/pkg/libtls-bearssl -L/src/oasis/out/pkg/bearssl' \
		libtls_LIBS='-ltls -lbearssl' \
		libtls_CFLAGS='-I/src/oasis/out/pkg/libtls-bearssl/include'
