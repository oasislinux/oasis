cflags{
	'-pedantic',
	'-D PREFIX=',
}

exe('rc', {
	'code.c',
	'exec.c',
	'getflags.c',
	'glob.c',
	'here.c',
	'io.c',
	'lex.c',
	'pcmd.c',
	'pfnc.c',
	'simple.c',
	'subr.c',
	'trap.c',
	'tree.c',
	'var.c',
	'y.tab.c',
	'unix.c',
	'havefork.c',
	'prompt-null.c',
})
file('bin/rc', '755', '$outdir/rc')
file('lib/rcmain', '644', '$srcdir/rcmain.unix')

fetch 'git'
