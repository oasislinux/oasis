cflags{
	'-std=c99', '-Wall',
	'-include $outdir/config.h',
	'-D _DEFAULT_SOURCE',
	'-D _FIDO_INTERNAL',
	'-I $builddir/pkg/libcbor/include',
	'-I $builddir/pkg/libressl/include',
	'-I $builddir/pkg/linux-headers/include',
	'-I $srcdir/src',
	'-I $basedir/pkg/openbsd/include',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/src', {
	'fido.h',
	'fido/credman.h',
	'fido/err.h',
	'fido/param.h',
})
pkg.deps = {
	'$outdir/config.h',
	'pkg/libcbor/headers',
	'pkg/libressl/headers',
	'pkg/linux-headers/headers',
}

build('cat', '$outdir/config.h', {
	'$builddir/probe/HAVE__THREAD_LOCAL',
	'$dir/config.h',
})

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
