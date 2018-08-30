cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $outdir/include',
}

build('sed', '$outdir/include/pixman-version.h', '$srcdir/pixman/pixman-version.h.in', {
	expr={
		'-e s,@PIXMAN_VERSION_MAJOR@,0,',
		'-e s,@PIXMAN_VERSION_MINOR@,34,',
		'-e s,@PIXMAN_VERSION_MICRO@,0,',
	},
})
pkg.hdrs = {
	copy('$outdir/include', '$srcdir/pixman', {'pixman.h'}),
	'$outdir/include/pixman-version.h',
}

-- processor-specific features
cflags{'-D USE_SSE2=1', '-D USE_SSSE3=1', '-D USE_X86_MMX=1'}
cc('pixman/pixman-mmx.c', {'$dir/headers'}, {cflags='$cflags -mmmx -Winline'})
cc('pixman/pixman-sse2.c', {'$dir/headers'}, {cflags='$cflags -msse2 -Winline'})
cc('pixman/pixman-ssse3.c', {'$dir/headers'}, {cflags='$cflags -mssse3 -Winline'})
local cpuobjs = {'pixman-mmx.c.o', 'pixman-sse2.c.o', 'pixman-ssse3.c.o'}

lib('libpixman.a', expand{'pixman/', {
	'pixman.c',
	'pixman-access.c',
	'pixman-access-accessors.c',
	'pixman-bits-image.c',
	'pixman-combine32.c',
	'pixman-combine-float.c',
	'pixman-conical-gradient.c',
	'pixman-filter.c',
	'pixman-x86.c',
	'pixman-mips.c',
	'pixman-arm.c',
	'pixman-ppc.c',
	'pixman-edge.c',
	'pixman-edge-accessors.c',
	'pixman-fast-path.c',
	'pixman-glyph.c',
	'pixman-general.c',
	'pixman-gradient-walker.c',
	'pixman-image.c',
	'pixman-implementation.c',
	'pixman-linear-gradient.c',
	'pixman-matrix.c',
	'pixman-noop.c',
	'pixman-radial-gradient.c',
	'pixman-region16.c',
	'pixman-region32.c',
	'pixman-solid-fill.c',
	'pixman-timer.c',
	'pixman-trap.c',
	'pixman-utils.c',
	cpuobjs,
}}, {'$dir/headers'})

fetch 'git'
