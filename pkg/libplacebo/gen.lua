cflags{
	'-std=c11', '-Wall',
	'-D _XOPEN_SOURCE=700',
	'-I $srcdir/src',
	'-I $srcdir/src/include',
	'-I $outdir/include',
	'-I $outdir',
	'-I $dir',
}

pkg.hdrs = copy('$outdir/include/libplacebo', '$srcdir/src/include/libplacebo', {
	-- src/src/meson.build:/^headers =/
	'cache.h',
	'colorspace.h',
	'common.h',
	'd3d11.h',
	'dispatch.h',
	'dither.h',
	'dummy.h',
	'filters.h',
	'gamut_mapping.h',
	'gpu.h',
	'log.h',
	'opengl.h',
	'options.h',
	'renderer.h',
	'shaders/colorspace.h',
	'shaders/custom.h',
	'shaders/deinterlacing.h',
	'shaders/dithering.h',
	'shaders/film_grain.h',
	'shaders/icc.h',
	'shaders/lut.h',
	'shaders/sampling.h',
	'shaders.h',
	'swapchain.h',
	'tone_mapping.h',
	'utils/dav1d.h',
	'utils/dav1d_internal.h',
	'utils/dolbyvision.h',
	'utils/frame_queue.h',
	'utils/libav.h',
	'utils/libav_internal.h',
	'utils/upload.h',
	'vulkan.h',
})
pkg.deps = {
	'$gendir/headers',
	'$outdir/version.h',
	'$outdir/include/libplacebo/config.h',
}

build('awk', '$outdir/version.h', '$dir/ver', {
	expr=[['{printf "#define BUILD_VERSION \"%s\"\n", $$1}']],
})
build('sed', '$outdir/include/libplacebo/config.h', '$srcdir/src/include/libplacebo/config.h.in', {
	expr={
		'-e s,@majorver@,7,',
		'-e s,@apiver@,349,',
		'-e /@extra_defs@/d',
	}
})

-- just enough to build mpv
lib('libplacebo.a', [[
	src/(
		colorspace.c
		common.c
	)

]])

fetch 'git'
