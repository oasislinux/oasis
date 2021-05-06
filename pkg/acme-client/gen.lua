set('srcdir', '$basedir/pkg/openbsd/src/usr.sbin/acme-client')
cflags{
	'-std=c11', '-Wall', '-Wpedantic', '-Wno-pointer-sign',
	'-D _GNU_SOURCE',  -- for memmem
	'-I $srcdir',
	'-isystem $basedir/pkg/openbsd/include',
	'-isystem $builddir/pkg/bearssl/include',
	'-isystem $builddir/pkg/libtls-bearssl/include',
	'-isystem $builddir/pkg/openbsd/include',
	'-isystem $builddir/pkg/x509cert/include',
}

pkg.deps = {
	'pkg/bearssl/headers',
	'pkg/libtls-bearssl/headers',
	'pkg/openbsd/headers',
	'pkg/x509cert/headers',
}

yacc('parse', 'parse.y')
exe('acme-client', [[
	acctproc.c base64.c certproc.c chngproc.c dbg.c dnsproc.c
	fileproc.c http.c jsmn.c json.c keyproc.c main.c netproc.c
	$outdir/parse.tab.c revokeproc.c key.c util.c
	$builddir/pkg/bearssl/libbearssl.a
	$builddir/pkg/libtls-bearssl/libtls.a.d
	$builddir/pkg/x509cert/libx509cert.a.d
]])
file('bin/acme-client', '755', '$outdir/acme-client')
man{'acme-client.1', 'acme-client.conf.5'}

build('phony', table.keys(pkg.inputs.fetch), 'pkg/openbsd/fetch');
