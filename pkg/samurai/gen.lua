cflags{
	'-Wall', '-Wextra', '-std=c99', '-pedantic',
	'-D _POSIX_C_SOURCE=200809L',
}

exe('samu', {
	'build.c',
	'deps.c',
	'env.c',
	'graph.c',
	'htab.c',
	'lex.c',
	'log.c',
	'parse.c',
	'samurai.c',
	'tool.c',
	'tree.c',
	'util.c',
})
file('bin/samu', '755', '$outdir/samu')
man{'samu.1'}

fetch 'git'
