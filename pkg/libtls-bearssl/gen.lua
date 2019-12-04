cflags{
	'-std=c11', '-Wall', '-Wpedantic',
	'-D _DEFAULT_SOURCE',
	'-I $builddir/pkg/bearssl/include',
	'-I $srcdir',
}

pkg.hdrs = copy('$outdir/include', '$srcdir', {'tls.h'})
pkg.deps = {
	'pkg/libressl/headers',
}

lib('libtls.a', {
	'tls.c',
	'tls_bio_cb.c',
	'tls_client.c',
	'tls_config.c',
	'tls_conninfo.c',
	'tls_keypair.c',
	'tls_ocsp.c',
	'tls_peer.c',
	'tls_server.c',
	'tls_util.c',
	'tls_verify.c',
	'bearssl.c',
	'$builddir/pkg/bearssl/libbearssl.a',
	'$builddir/pkg/openbsd/libbsd.a',
})

fetch 'git'
