set('srcdir', 'pkg/openbsd/src/usr.sbin/acme-client')
cflags{
	'-D _GNU_SOURCE',  -- for memmem
	'-I pkg/openbsd/include',
	'-I $builddir/pkg/libressl/include',
	'-I $srcdir',
	'-idirafter pkg/openbsd/src/sys',
}

pkg.deps = {
	'pkg/libressl/headers',
}

yacc('parse', 'parse.y')
exe('acme-client', [[
	acctproc.c base64.c certproc.c chngproc.c dbg.c dnsproc.c
	fileproc.c http.c jsmn.c json.c keyproc.c main.c netproc.c
	$outdir/parse.tab.c revokeproc.c key.c util.c
	$builddir/pkg/libressl/libtls.a.d
]])
file('bin/acme-client', '755', '$outdir/acme-client')
man{'acme-client.1', 'acme-client.conf.5'}

build('phony', table.keys(pkg.inputs.fetch), 'pkg/openbsd/fetch');
