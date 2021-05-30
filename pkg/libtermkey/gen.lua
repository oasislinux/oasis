cflags{
	'-std=c99', '-Wall',
	'-isystem $builddir/pkg/netbsd-curses/include',
}

pkg.hdrs = copy('$outdir/include', '$srcdir', {'termkey.h'})
pkg.deps = {'pkg/netbsd-curses/headers'}

lib('libtermkey.a', {
	'termkey.c',
	'driver-csi.c',
	'driver-ti.c',
	'$builddir/pkg/netbsd-curses/libcurses.a.d',
})

fetch 'curl'
