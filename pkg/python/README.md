# python

## config.h
Generated with

	./configure \
		--without-pymalloc \
		--with-builtin-hashlib-hashes='sha3,blake2' \
		--with-ssl-default-suites='TLSv1.3:TLSv1.2+AEAD+ECDHE:TLSv1.2+AEAD+DHE' \
		ax_cv_c_float_words_bigendian=no

Use libtls's conversative default set of cipher suites since the
python default uses `@SECLEVEL=2`, which is not supported by libressl.

`HAVE_GCC_ASM_FOR_X64` and `HAVE_GCC_ASM_FOR_X87` were guarded by
`#ifdef __x86_64__` for compatibility with other architectures.
