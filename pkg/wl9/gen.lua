cflags{
	'-std=c11', '-Wall', '-Wpedantic', '-Wno-parentheses',
	'-isystem $builddir/pkg/wayland/include',
}
pkg.deps = {
	'pkg/wayland/headers',
	'pkg/wayland-protocols/headers',
}

exe('wl9', {
	'wl9.c',
	'c9.c',
	'fs.c',
	'util.c',
	'keymap.c',
	'server-decoration-protocol.c',
	'$builddir/pkg/wayland-protocols/xdg-shell-protocol.c.o',
	'$builddir/pkg/wayland/libwayland-server.a.d',
})
file('bin/wl9', '755', '$outdir/wl9')

fetch 'git'
