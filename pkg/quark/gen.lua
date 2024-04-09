cflags {
	'-std=c99', '-pedantic', '-Wall', '-Wextra',
	'-D _DEFAULT_SOURCE',
	'-D _XOPEN_SOURCE=700',
	'-D _BSD_SOURCE',
	'-D VERSION=0',
	'-I $dir',
}

exe('quark', {
	'main.c',
	'connection.c',
	'data.c',
	'http.c',
	'queue.c',
	'server.c',
	'sock.c',
	'util.c',
})

file('bin/quark', '775', '$outdir/quark')

man{'quark.1'}

fetch 'git'
