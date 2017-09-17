cflags{
	'-I include',
	'-I $dir',
	'-I $outdir/include',
	'-I $srcdir',
	'-I $srcdir/src',
	'-I $builddir/pkg/expat/include',
	'-I $builddir/pkg/libffi/include',
}

build('sed', '$outdir/include/wayland-version.h', '$srcdir/src/wayland-version.h.in', {
	expr={
		'-e s,@WAYLAND_VERSION_MAJOR@,1,',
		'-e s,@WAYLAND_VERSION_MINOR@,11,',
		'-e s,@WAYLAND_VERSION_MICRO@,0,',
		'-e s,@WAYLAND_VERSION@,1.11.0,',
	},
})

cc('src/wayland-util.c')
cc('src/wayland-os.c')
cc('src/connection.c', {'pkg/libffi/headers'})

waylandproto('protocol/wayland.xml',
	'include/wayland-client-protocol.h',
	'include/wayland-server-protocol.h',
	'src/wayland-protocol.c'
)

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/src', {
		'wayland-client-core.h',
		'wayland-client.h',
		'wayland-egl-core.h',
		'wayland-egl.h',
		'wayland-server-core.h',
		'wayland-server.h',
		'wayland-util.h',
	}),
	copy('$outdir/include', '$srcdir/cursor', {'wayland-cursor.h'}),
}
pkg.deps = {
	'$dir/headers',
	'$outdir/include/wayland-version.h',
	'pkg/expat/headers',
}

exe('wayland-scanner', {'src/scanner.c', 'src/wayland-util.c.o', '$builddir/pkg/expat/libexpat.a.d'})
file('bin/wayland-scanner', '755', '$outdir/wayland-scanner')

lib('libwayland-server.a', [[src/(
	connection.c.o
	wayland-os.c.o
	wayland-protocol.c.o
	wayland-server.c
	wayland-shm.c
	wayland-util.c.o
	event-loop.c
) $builddir/pkg/libffi/libffi.a]])

lib('libwayland-client.a', [[src/(
	connection.c.o
	wayland-os.c.o
	wayland-protocol.c.o
	wayland-client.c
	wayland-util.c.o
) $builddir/pkg/libffi/libffi.a]])

lib('libwayland-cursor.a', [[cursor/(
	os-compatibility.c
	wayland-cursor.c
	xcursor.c
) libwayland-client.a.d]])

fetch 'git'
