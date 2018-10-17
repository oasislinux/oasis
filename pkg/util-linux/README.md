# util-linux

## config.h
Generated with

	./configure \
		--disable-all-programs \
		--enable-fs-paths-default=/bin \
		--enable-fsck \
		--enable-libblkid \
		--enable-libmount \
		--enable-libuuid

`HAVE_LIBBLKID` and `HAVE_LIBMOUNT` were undefined because although configure
requires that we enable them, they aren't actually needed to build fdisk.

`_PATH_RUNSTATEDIR` and `LOCALEDIR` are defined in a separate top section. They
are normally defined with flags in `Makefile.am`.

`HAVE_IOPERM` was removed since it appears to be unused. `HAVE_IOPL`
was removed since it is only used by `sys-utils/hwclock-cmos.c`,
which we don't build.
