cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-I $basedir/pkg/libdrm/src',
	'-I $basedir/pkg/libdrm/src/include/drm',
	'-I $srcdir/include',
}

pkg.deps = {
	'$basedir/pkg/libdrm/fetch',
}

lib('libliftoff.a', {
	'alloc.c',
	'device.c',
	'layer.c',
	'list.c',
	'log.c',
	'output.c',
	'plane.c',
})

fetch 'git'
