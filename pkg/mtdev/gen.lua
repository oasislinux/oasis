cflags{'-I $srcdir/include'}

lib('libmtdev.a', {
	'src/caps.c',
	'src/core.c',
	'src/iobuf.c',
	'src/match.c',
	'src/match_four.c',
})

fetch 'git'
