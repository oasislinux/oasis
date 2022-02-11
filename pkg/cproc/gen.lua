cflags{
	'-std=c11', '-Wall', '-Wpedantic', '-Wno-switch', '-Wno-parentheses', '-Wno-maybe-uninitialized',
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
	'utf.c',
})
file('bin/cproc', '755', '$outdir/cproc')
file('bin/cproc-qbe', '755', '$outdir/cproc-qbe')

fetch 'git'
