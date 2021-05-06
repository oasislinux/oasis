cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-I $srcdir',
	'-I $builddir/pkg/bearssl/include',
}

pkg.deps = {'pkg/bearssl/headers'}
pkg.hdrs = copy('$outdir/include', '$srcdir', {'x509cert.h'})

lib('libx509cert.a', {
	'cert.c',
	'der.c',
	'dn.c',
	'dn_string.c',
	'oid.c',
	'pkey.c',
	'req.c',
	'san.c',
	'sign.c',
	'$builddir/pkg/bearssl/libbearssl.a',
})

exe('x509cert', {'x509cert.c', 'libx509cert.a.d'})
file('bin/x509cert', '755', '$outdir/x509cert')
man{'x509cert.1'}

fetch 'git'
