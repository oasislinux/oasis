cflags{
	'-std=c99', '-Wall',
	'-isystem $builddir/pkg/ncurses/include',
}

pkg.hdrs = copy('$outdir/include', '$srcdir', {'termkey.h'})
pkg.deps = {'pkg/ncurses/headers'}

lib('libtermkey.a', {
	'termkey.c',
	'driver-csi.c',
	'driver-ti.c',
	'$builddir/pkg/ncurses/libncurses.a',
})

fetch 'curl'
