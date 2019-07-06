cflags{
	'-std=c11', '-pedantic',
	'-Wall', '-Wno-switch', '-Wno-parentheses',
	'-I $dir',
}

cc('util.c')

exe('cproc', {'driver.c', 'util.c.o'})
exe('cproc-qbe', {
	'decl.c',
	'eval.c',
	'expr.c',
	'init.c',
	'main.c',
	'map.c',
	'pp.c',
	'qbe.c',
	'scan.c',
	'scope.c',
	'siphash.c',
	'stmt.c',
	'targ.c',
	'token.c',
	'tree.c',
	'type.c',
	'util.c.o',
})
file('bin/cproc', '755', '$outdir/cproc')
file('bin/cproc-qbe', '755', '$outdir/cproc-qbe')

fetch 'git'
