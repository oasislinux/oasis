cflags{
	[[-D 'VERSION="4.6"']],
	'-I $dir',
	'-I $builddir/pkg/fontconfig/include',
	'-I $basedir/pkg/libxkbcommon/src',
	'-I $builddir/pkg/pixman/include',
	'-I $builddir/pkg/swc/include',
	'-I $builddir/pkg/wayland/include',
	'-I $builddir/pkg/wld/include',
}

pkg.deps = {
	'pkg/fontconfig/headers',
	'pkg/libxkbcommon/fetch',
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
