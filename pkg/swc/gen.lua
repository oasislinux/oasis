cflags{
	'-Wall',
	'-D _GNU_SOURCE',
	'-D screen_new=swc__screen_new',
	'-D remove_resource=swc__remove_resource',
	'-I $outdir',
	'-I $outdir/include',
	'-I $srcdir',
	'-I $builddir/pkg/fontconfig/include',
	'-I $builddir/pkg/libinput/include',
	'-I $builddir/pkg/libxkbcommon/include',
	'-I $builddir/pkg/libdrm/include',
	'-I $builddir/pkg/linux-headers/include',
	'-I $builddir/pkg/pixman/include',
	'-I $builddir/pkg/wayland-protocols/include',
	'-I $builddir/pkg/wayland/include',
	'-I $builddir/pkg/wld/include',
}

cc('launch/protocol.c')

waylandproto('protocol/swc.xml', {
	client='include/swc-client-protocol.h',
	server='include/swc-server-protocol.h',
	code='swc-protocol.c',
})

waylandproto('protocol/server-decoration.xml', {
	server='include/server-decoration-server-protocol.h',
	code='server-decoration-protocol.c',
})

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/libswc', {'swc.h'}),
	'$outdir/include/server-decoration-server-protocol.h',
	'$outdir/include/swc-client-protocol.h',
	'$outdir/include/swc-server-protocol.h',
}

copy('$outdir', '$builddir/pkg/wld/protocol', {'wayland-drm-server-protocol.h'})

sub('tools.ninja', function()
	toolchain(config.host)
	cflags{'-std=c99', '-D _POSIX_C_SOURCE=200809L'}
	exe('convert_font', {'cursor/convert_font.c'})
end)

rule('convert_font', '$outdir/convert_font $in $out 2>/dev/null')
build('convert_font', '$outdir/cursor/cursor_data.h', {'$srcdir/cursor/cursor.pcf', '|', '$outdir/convert_font'})

pkg.deps = {
	'$outdir/wayland-drm-server-protocol.h',
	'$outdir/include/swc-server-protocol.h',
	'$outdir/cursor/cursor_data.h',
	'pkg/fontconfig/headers',
	'pkg/libdrm/headers',
	'pkg/libinput/headers',
	'pkg/libxkbcommon/headers',
	'pkg/linux-headers/headers',
	'pkg/pixman/headers',
	'pkg/wayland/headers',
	'pkg/wayland-protocols/headers',
	'pkg/wld/headers',
}

lib('libswc.a', [[
	libswc/(
		bindings.c
		compositor.c
		data.c
		data_device.c
		data_device_manager.c
		dmabuf.c
		drm.c
		input.c
		kde_decoration.c
		keyboard.c
		launch.c
		mode.c
		output.c
		panel.c
		panel_manager.c
		plane.c
		pointer.c
		primary_plane.c
		region.c
		screen.c
		shell.c
		shell_surface.c
		seat.c
		shm.c
		subcompositor.c
		subsurface.c
		surface.c
		swc.c
		util.c
		view.c
		wayland_buffer.c
		window.c
		xdg_decoration.c
		xdg_shell.c
	)
	launch/protocol.c.o
	server-decoration-protocol.c.o
	swc-protocol.c.o
	$builddir/(
		pkg/libinput/libinput.a.d
		pkg/libxkbcommon/libxkbcommon.a
		pkg/wayland-protocols/xdg-decoration-unstable-v1-protocol.c.o
		pkg/wayland-protocols/xdg-shell-protocol.c.o
		pkg/wayland-protocols/linux-dmabuf-unstable-v1-protocol.c.o
		pkg/wayland/libwayland-server.a.d
		pkg/wld/libwld.a.d
	)
]])

exe('swc-launch', {'launch/launch.c', 'launch/devmajor-linux.c', 'launch/protocol.c.o', '$builddir/pkg/libdrm/libdrm.a'})
file('bin/swc-launch', '4755', '$outdir/swc-launch')

fetch 'git'
