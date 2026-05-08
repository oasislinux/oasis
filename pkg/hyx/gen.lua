cflags{'-std=c99', '-Wall', '-Wextra', '-Wpedantic', '-DNDEBUG'}

exe('hyx', {
	'blob.c',
	'common.c',
	'history.c',
	'hyx.c',
	'input.c',
	'term.c',
	'view.c',
})
file('bin/hyx', '755', '$outdir/hyx')

fetch 'curl'
