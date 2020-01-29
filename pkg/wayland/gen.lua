cflags{
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
		'-e s,@WAYLAND_VERSION_MINOR@,17,',
		'-e s,@WAYLAND_VERSION_MICRO@,0,',
		'-e s,@WAYLAND_VERSION@,1.17.0,',
	},
})

waylandproto('protocol/wayland.xml', {
	client='include/wayland-client-protocol.h',
	server='include/wayland-server-protocol.h',
	code='src/wayland-protocol.c'
})

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/src', {
		'wayland-client-core.h',
		'wayland-client.h',
		'wayland-server-core.h',
		'wayland-server.h',
		'wayland-util.h',
	}),
	copy('$outdir/include', '$srcdir/cursor', {'wayland-cursor.h'}),
	'$outdir/include/wayland-client-protocol.h',
	'$outdir/include/wayland-server-protocol.h',
	'$outdir/include/wayland-version.h',
}
pkg.deps = {
	'$gendir/headers',
	'$outdir/include/wayland-version.h',
	'pkg/libffi/headers',
}

cc('src/wayland-util.c', {'$outdir/include/wayland-version.h'})
cc('src/wayland-os.c')
cc('src/connection.c')

exe('wayland-scanner', [[
	src/(
		scanner.c
		wayland-util.c.o
	)
	$builddir/pkg/expat/libexpat.a.d
]], {'pkg/expat/headers', '$outdir/include/wayland-version.h'})
file('bin/wayland-scanner', '755', '$outdir/wayland-scanner')

lib('libwayland-server.a', [[
	src/(
		connection.c.o
		wayland-os.c.o
		wayland-protocol.c.o
		wayland-server.c
		wayland-shm.c
		wayland-util.c.o
		event-loop.c
	)
	$builddir/pkg/libffi/libffi.a
]])

lib('libwayland-client.a', [[
	src/(
		connection.c.o
		wayland-os.c.o
		wayland-protocol.c.o
		wayland-client.c
		wayland-util.c.o
	)
	$builddir/pkg/libffi/libffi.a
]])

lib('libwayland-cursor.a', [[
	cursor/(
		os-compatibility.c
		wayland-cursor.c
		xcursor.c
	)
	libwayland-client.a.d
]])

fetch 'git'
