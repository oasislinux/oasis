cflags{
	'-Wpedantic',
	'-I $srcdir',
	'-I $outdir',
	([['-D PREFIX="%s"']]):format(config.prefix),
}

yacc('y', 'syn.y')

exe('rc', [[
	code.c exec.c getflags.c glob.c
	here.c io.c lex.c pcmd.c pfnc.c
	simple.c subr.c trap.c tree.c
	var.c unix.c havefork.c

	$outdir/y.tab.c
]])
file('bin/rc', '755', '$outdir/rc')
man{'rc.1'}

file('lib/rcmain', '644', '$srcdir/rcmain.unix')

fetch 'git'
