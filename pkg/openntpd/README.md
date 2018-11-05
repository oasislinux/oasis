# openntpd

## config.h
Generated with

	./configure \
		--with-privsep-user=ntpd \
		CPPFLAGS='-I/src/oasis/out/pkg/libressl/include' \
		LDFLAGS='-L/src/oasis/out/pkg/libressl -L/src/oasis/out/pkg/openbsd' \
		LIBS='-ltls -lssl -lcrypto -lbsd'
