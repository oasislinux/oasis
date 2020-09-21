# openssh

## config.h
Generated with

	./configure \
		--disable-pkcs11 \
		--disable-wtmp \
		--enable-security-key \
		--without-pie \
		--with-security-key-builtin \
		--with-bearssl \
		CPPFLAGS='-I/src/oasis/pkg/openbsd/include -I/src/oasis/out/pkg/libfido2/include -I/src/oasis/out/pkg/zlib/include' \
		LDFLAGS='-L/src/oasis/out/pkg/bearssl -L/src/oasis/out/pkg/openbsd -L/src/oasis/out/pkg/libfido2 -L/src/oasis/out/pkg/libcbor -L/src/oasis/out/pkg/zlib' \
		LIBS='-l bsd'

Several changes were made:
* `SECCOMP_AUDIT_ARCH`, `SANDBOX_SECCOMP_FILTER`, and `SANDBOX_RLIMIT`
  were removed and instead defined in `gen.lua` dependent on the
  target toolchain architecture.
* `HAVE_STRNVIS` was undefined because although we do build it into
  `libbsd.a`, we don't include the whole openbsd header directory.
* `HAVE_PLEDGE` is defined because we have a stub definition in
  `pkg/openbsd/include/unistd.h`.
* `SIZEOF_*` are undefined because they are only used if C99 `int*_t` are not
  available.
* `_PATH_BTMP`, `_PATH_PASSWD_PROG`, `_PATH_SSH_PIDDIR` are moved to a top
  section along with a number of other paths which are normally defined
  with flags by the Makefile or automatically by `pathnames.h`.
