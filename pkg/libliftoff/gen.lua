cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-I $builddir/pkg/libdrm/include',
	'-I $srcdir/include',
}

pkg.deps = {
	'pkg/libdrm/headers',
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
