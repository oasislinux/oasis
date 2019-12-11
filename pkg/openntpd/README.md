# openntpd

## config.h
Generated with

	./configure \
		--with-privsep-user=ntpd \
		CPPFLAGS='-I/src/oasis/out/pkg/libtls-bearssl/include' \
		LDFLAGS='-L/src/oasis/out/pkg/libtls-bearssl -L/src/oasis/out/pkg/openbsd' \
		LIBS='-ltls -lbearssl -lbsd'
