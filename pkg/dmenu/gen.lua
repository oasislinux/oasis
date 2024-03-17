cflags{
	'-std=c99', '-Wall', '-Wpedantic', '-Wno-maybe-uninitialized',
	'-D _POSIX_C_SOURCE=200809L',
	[[-D 'VERSION="4.6"']],
	'-I $dir',
	'-isystem $builddir/pkg/fontconfig/include',
	'-isystem $builddir/pkg/libxkbcommon/include',
	'-isystem $builddir/pkg/pixman/include',
	'-isystem $builddir/pkg/swc/include',
	'-isystem $builddir/pkg/wayland/include',
	'-isystem $builddir/pkg/wld/include',
}

pkg.deps = {
	'pkg/fontconfig/headers',
	'pkg/libxkbcommon/headers',
	'pkg/pixman/headers',
	'pkg/swc/headers',
	'pkg/wayland/headers',
	'pkg/wld/headers',
}

exe('dmenu', [[
	dmenu.c drw.c util.c
	$builddir/pkg/(
		swc/swc-protocol.c.o
		libxkbcommon/libxkbcommon.a
		wld/libwld.a.d
		fontconfig/libfontconfig.a.d
		wayland/libwayland-client.a.d
	)
]])
file('bin/dmenu', '755', '$outdir/dmenu')
man{'dmenu.1'}

exe('stest', {'stest.c'})
file('bin/stest', '755', '$outdir/stest')
man{'stest.1'}

file('bin/dmenu_path', '755', '$srcdir/dmenu_path')
file('bin/dmenu_run', '755', '$srcdir/dmenu_run')

fetch 'git'
