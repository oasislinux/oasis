cflags{
	'-std=c99',
	'-D NDEBUG',
	'-I pkg/lua/src/src',
}

lib('liblpeg.a', {
	'lpvm.c',
	'lpcap.c',
	'lptree.c',
	'lpcode.c',
	'lpprint.c',
}, {'pkg/lua/fetch'})

fetch 'curl'
