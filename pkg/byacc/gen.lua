cflags{
	'-Wall', '-Wpedantic',
	'-D HAVE_CONFIG_H',
	'-D YYPATCH=20220128',
	'-I $dir',
}

exe('yacc', {
	'closure.c',
	'error.c',
	'graph.c',
	'lalr.c',
	'lr0.c',
	'main.c',
	'mkpar.c',
	'mstring.c',
	'output.c',
	'reader.c',
	'yaccpar.c',
	'symtab.c',
	'verbose.c',
	'warshall.c',
})
file('bin/yacc', '755', '$outdir/yacc')
man{'yacc.1'}

fetch 'curl'
