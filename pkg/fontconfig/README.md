# fontconfig

fontconfig is used by only dmenu, st, velox, and wld. It should be removed after
updating those programs to just open font files directly.

## config.h

Generated with

	./configure \
		--disable-nls \
		--with-default-fonts=/share/fonts \
		FREETYPE_CFLAGS=-I/src/oasis/out/pkg/freetype/include \
		FREETYPE_LIBS=/src/oasis/out/pkg/freetype/libfreetype.a \
		UUID_CFLAGS=-I/src/oasis/out/pkg/util-linux/include \
		UUID_LIBS=/src/oasis/out/pkg/util-linux/libuuid.a \
		EXPAT_CFLAGS=-I/src/oasis/out/pkg/expat/include \
		EXPAT_LIBS='/src/oasis/out/pkg/expat/libexpat.a /src/oasis/out/pkg/openbsd/libbsd.a /src/oasis/out/pkg/libressl/libcrypto-sha.a'
