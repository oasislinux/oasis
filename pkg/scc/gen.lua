set('arch', 'qbe')
cflags{
	'-std=c99',
	[[-D 'SYS="linux"']],
	[[-D 'ARCH="$arch"']],
	'-D PREFIX=',
	'-D NDEBUG',
	'-I $dir/inc',
	'-I $srcdir/inc/c99',
	'-I $outdir/inc',
}

lib('libcc.a', {
	'lib/debug.c',
	'lib/die.c',
	'lib/newitem.c',
	'lib/xcalloc.c',
	'lib/xmalloc.c',
	'lib/xrealloc.c',
	'lib/xstrdup.c',
})

build('awk', '$outdir/inc/error.h', {'$srcdir/cc2/cc2.h', '|', '$srcdir/cc2/generror.awk'}, {
	expr='-f $srcdir/cc2/generror.awk',
})

cflags{[[-D 'ARCH="$arch"']]}

exe('cc1-$arch', [[cc1/(
	types.c decl.c lex.c error.c symbol.c main.c expr.c
	code.c stmt.c cpp.c fold.c init.c builtin.c
	arch/$arch/arch.c
) $outdir/libcc.a]])
file('libexec/scc/cc1-$arch', '755', '$outdir/cc1-$arch')

exe('cc2-$arch', [[cc2/(
	main.c parser.c peep.c symbol.c node.c code.c optm.c
	arch/$arch/(code.c cgen.c types.c optm.c)
) $outdir/libcc.a]], {'$outdir/inc/error.h'})
file('libexec/scc/cc2-$arch', '755', '$outdir/cc2-$arch')

exe('scc', {'driver/posix/scc.c', 'libcc.a'})
file('bin/scc', '755', '$outdir/scc')

fetch 'git'
