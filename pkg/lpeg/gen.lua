cflags{
	'-std=c99',
	'-D NDEBUG',
	'-isystem $builddir/pkg/lua/include',
}

pkg.deps = {'pkg/lua/headers'}

lib('liblpeg.a', {
	'lpvm.c',
	'lpcap.c',
	'lptree.c',
	'lpcode.c',
	'lpprint.c',
})

fetch 'curl'
