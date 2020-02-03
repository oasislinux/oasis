cflags{'-I $srcdir/include'}
lib('libnsutils.a', {
	'src/base64.c',
	'src/time.c',
	'src/unistd.c',
})

fetch 'git'
