cflags{'-Wall', '-Wextra', '-std=c99', '-pedantic'}

exe('samu', {
	'build.c',
	'deps.c',
	'env.c',
	'graph.c',
	'htab.c',
	'log.c',
	'parse.c',
	'samurai.c',
	'scan.c',
	'tool.c',
	'tree.c',
	'util.c',
})
file('bin/samu', '755', '$outdir/samu')
man{'samu.1'}

fetch 'git'
