cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-I $srcdir/include',
	'-isystem $builddir/pkg/libdrm/include',
}

pkg.hdrs = copy('$outdir/include', '$dir', {'$liftoff.h'})
pkg.deps = {'pkg/libdrm/headers'}

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
