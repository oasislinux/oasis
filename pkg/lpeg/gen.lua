cflags{
	'-std=c99',
	'-I pkg/lua/src/src',
}

lib('liblpeg.a', {
	'lpvm.c',
	'lpcap.c',
	'lptree.c',
	'lpcode.c',
	'lpprint.c',
}, {'$builddir/pkg/lua/fetch.stamp'})

fetch 'curl'
