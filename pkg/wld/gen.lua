cflags{
	'-D WITH_WAYLAND_SHM',
	'-D WITH_WAYLAND_DRM',
	'-I $outdir',
	'-I $builddir/pkg/fontconfig/include',
	'-I $builddir/pkg/freetype/include',
	'-I $builddir/pkg/libdrm/include',
	'-I $builddir/pkg/linux-headers/include',
	'-I $builddir/pkg/pixman/include',
	'-I $builddir/pkg/wayland/include',
}

pkg.hdrs = copy('$outdir/include/wld', '$srcdir', {'drm.h', 'pixman.h', 'wayland.h', 'wld.h'})
pkg.hdrs.install = true

local srcs = {
	'buffer.c',
	'buffered_surface.c',
	'color.c',
	'context.c',
	'drm.c',
	'dumb.c',
	'font.c',
	'renderer.c',
	'surface.c',
	'pixman.c',
	'wayland.c',
	'wayland-shm.c',
	'wayland-drm.c',
	'wayland-drm-protocol.c.o',
}
local libs = {
	'fontconfig/libfontconfig.a.d',
	'freetype/libfreetype.a.d',
	'libdrm/libdrm.a',
	'pixman/libpixman.a',
	'wayland/libwayland-client.a.d',
}

if config.video_drivers and config.video_drivers['intel'] then
	cflags{'-D WITH_DRM_INTEL', '-I $basedir/pkg/libdrm/src/intel'}
	table.insert(srcs, {'intel.c', 'intel/batch.c'})
	table.insert(libs, 'libdrm/libdrm_intel.a.d')
end
if config.video_drivers and config.video_drivers['nouveau'] then
	cflags{'-D WITH_DRM_NOUVEAU', '-I $basedir/pkg/libdrm/src/nouveau'}
	table.insert(srcs, 'nouveau.c')
	table.insert(libs, 'libdrm/libdrm_nouveau.a')
end

waylandproto('protocol/wayland-drm.xml', {
	client='protocol/wayland-drm-client-protocol.h',
	server='protocol/wayland-drm-server-protocol.h',
	code='wayland-drm-protocol.c'
})

pkg.deps = {
	'$outdir/protocol/wayland-drm-client-protocol.h',
	'pkg/fontconfig/headers',
	'pkg/freetype/headers',
	'pkg/libdrm/headers',
	'pkg/linux-headers/headers',
	'pkg/pixman/headers',
	'pkg/wayland/headers',
}

lib('libwld.a', {srcs, expand{'$builddir/pkg/', libs}})

fetch 'git'
