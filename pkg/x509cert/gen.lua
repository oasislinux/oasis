cflags{
	'-std=c99', '-Wall', '-Wpedantic', '-Wno-format-truncation',
	'-I $srcdir',
	'-I $builddir/pkg/bearssl/include',
}

pkg.deps = {'pkg/bearssl/headers'}

lib('libx509cert.a', {
	'asn1.c',
	'cert.c',
	'dn.c',
	'dn_string.c',
	'oid.c',
	'pkey.c',
	'req.c',
	'san.c',
	'sign.c',
})

exe('x509cert', {'x509cert.c', 'libx509cert.a', '$builddir/pkg/bearssl/libbearssl.a'})
file('bin/x509cert', '755', '$outdir/x509cert')
man{'x509cert.1'}

fetch 'git'
