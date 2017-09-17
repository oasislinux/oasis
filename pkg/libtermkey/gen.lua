cflags{
	'-std=c99', '-Wall',
	'-I $builddir/pkg/ncurses/include',
}

lib('libtermkey.a', {
	'termkey.c',
	'driver-csi.c',
	'driver-ti.c',
	'$builddir/pkg/ncurses/libncurses.a',
}, {'pkg/ncurses/headers'})

fetch 'curl'
