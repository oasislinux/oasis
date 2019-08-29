cflags{
	'-Wall',
	'-D _GNU_SOURCE',
	'-D screen_new=swc__screen_new',
	'-D remove_resource=swc__remove_resource',
	'-I $outdir',
	'-I $outdir/include',
	'-I $srcdir',
	'-I pkg/fontconfig/src',
	'-I pkg/libdrm/src/include/drm',
	'-I pkg/libdrm/src',
	'-I pkg/libinput/src/src',
	'-I pkg/libxkbcommon/src',
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

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/libswc', {'swc.h'}),
	'$outdir/include/swc-client-protocol.h',
	'$outdir/include/swc-server-protocol.h',
}

copy('$outdir', '$builddir/pkg/wld/protocol', {'wayland-drm-server-protocol.h'})

sub('tools.ninja', function()
	toolchain 'host'
	cflags{'-std=c99', '-D _POSIX_C_SOURCE=200809L'}
	exe('convert_font', {'cursor/convert_font.c'})
end)

rule('convert_font', '$outdir/convert_font $in $out.tmp 2>/dev/null && mv $out.tmp $out')
build('convert_font', '$outdir/cursor/cursor_data.h', {'$srcdir/cursor/cursor.pcf', '|', '$outdir/convert_font'})

pkg.deps = {
	'$outdir/wayland-drm-server-protocol.h',
	'$outdir/include/swc-server-protocol.h',
	'$outdir/cursor/cursor_data.h',
	'pkg/fontconfig/fetch',
	'pkg/libdrm/fetch',
	'pkg/libinput/fetch',
	'pkg/libxkbcommon/fetch',
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
		xdg_shell.c
	)
	launch/protocol.c.o
	swc-protocol.c.o
	$builddir/(
		pkg/libinput/libinput.a.d
		pkg/libxkbcommon/libxkbcommon.a
		pkg/wayland-protocols/xdg-shell-protocol.c.o
		pkg/wayland-protocols/linux-dmabuf-unstable-v1-protocol.c.o
		pkg/wayland/libwayland-server.a.d
		pkg/wld/libwld.a.d
	)
]])

exe('swc-launch', {'launch/launch.c', 'launch/protocol.c.o', '$builddir/pkg/libdrm/libdrm.a'})
file('bin/swc-launch', '4755', '$outdir/swc-launch')

fetch 'git'
