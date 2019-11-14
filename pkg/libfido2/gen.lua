cflags{
	'-include $dir/config.h',
	'-D _FIDO_INTERNAL',
	'-I $builddir/pkg/libcbor/include',
	'-I $builddir/pkg/libressl/include',
	'-I $srcdir/src',
	'-I pkg/openbsd/include',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/src', {
	'fido.h',
	'fido/err.h',
	'fido/param.h',
})
pkg.deps = {
	'pkg/libcbor/headers',
	'pkg/libressl/headers',
}

lib('libfido2.a', [[
	src/(
		aes256.c
		assert.c
		authkey.c
		bio.c
		blob.c
		buf.c
		cbor.c
		cred.c
		credman.c
		dev.c
		ecdh.c
		eddsa.c
		err.c
		es256.c
		hid.c
		info.c
		io.c
		iso7816.c
		log.c
		pin.c
		reset.c
		rs256.c
		u2f.c

		hid_linux.c
	)
	$builddir/pkg/libcbor/libcbor.a
]])

fetch 'git'
