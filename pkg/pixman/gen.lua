cflags{
	'-D HAVE_CONFIG_H',
	'-I $outdir',
	'-I $outdir/include',
}

build('cat', '$outdir/config.h', {
	'$builddir/probe/HAVE__THREAD_LOCAL',
	'$builddir/probe/HAVE___BUILTIN_CLZ',
	'$dir/config.h',
})

build('sed', '$outdir/include/pixman-version.h', '$srcdir/pixman/pixman-version.h.in', {
	expr={
		'-e s,@PIXMAN_VERSION_MAJOR@,0,',
		'-e s,@PIXMAN_VERSION_MINOR@,38,',
		'-e s,@PIXMAN_VERSION_MICRO@,0,',
	},
})

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/pixman', {'pixman.h'}),
	'$outdir/include/pixman-version.h',
}
pkg.deps = {
	'$gendir/headers',
	'$outdir/config.h',
}

-- x86_64
cc('pixman/pixman-mmx.c', nil, {cflags='$cflags -mmmx -Winline'})
cc('pixman/pixman-sse2.c', nil, {cflags='$cflags -msse2 -Winline'})
cc('pixman/pixman-ssse3.c', nil, {cflags='$cflags -mssse3 -Winline'})

lib('libpixman.a', [[
	pixman/(
		pixman.c
		pixman-access.c
		pixman-access-accessors.c
		pixman-bits-image.c
		pixman-combine32.c
		pixman-combine-float.c
		pixman-conical-gradient.c
		pixman-filter.c
		pixman-x86.c
		pixman-mips.c
		pixman-arm.c
		pixman-ppc.c
		pixman-edge.c
		pixman-edge-accessors.c
		pixman-fast-path.c
		pixman-glyph.c
		pixman-general.c
		pixman-gradient-walker.c
		pixman-image.c
		pixman-implementation.c
		pixman-linear-gradient.c
		pixman-matrix.c
		pixman-noop.c
		pixman-radial-gradient.c
		pixman-region16.c
		pixman-region32.c
		pixman-solid-fill.c
		pixman-timer.c
		pixman-trap.c
		pixman-utils.c
		@x86_64(pixman-mmx.c.o pixman-sse2.c.o pixman-ssse3.c.o)
	)
]])

fetch 'git'
