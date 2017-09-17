cflags{
	'-D _GNU_SOURCE',
	'-I pkg/openbsd/include',
	'-I $builddir/pkg/libressl/include',
}

pkg.deps = {'pkg/libressl/headers'}

exe('acme-client', {
	'acctproc.c',
	'base64.c',
	'certproc.c',
	'chngproc.c',
	'dbg.c',
	'dnsproc.c',
	'fileproc.c',
	'http.c',
	'jsmn.c',
	'json.c',
	'keyproc.c',
	'main.c',
	'netproc.c',
	'revokeproc.c',
	'rsa.c',
	'sandbox-pledge.c',
	'util.c',
	'util-pledge.c',
	'$builddir/pkg/libressl/libtls.a.d',
})
file('bin/acme-client', '755', '$outdir/acme-client')
man{'acme-client.1'}

fetch 'git'
