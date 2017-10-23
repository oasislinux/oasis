cflags{
	'-I include',
	'-I $dir',
	'-I pkg/freetype/src/include',
	'-I $builddir/pkg/fribidi/include',
}

set('nasmflags', {
	'-w -orphan-labels',
	'-D ARCH_X86_64=1',
	'-D HAVE_ALIGNED_STACK=1',
	'-i $srcdir/libass/x86/',
	'-f elf64',
})

pkg.hdrs = copy('$outdir/include/ass', '$srcdir/libass', {'ass.h', 'ass_types.h'})
pkg.deps = {
	'pkg/freetype/fetch',
	'pkg/fribidi/headers',
}

lib('libass.a', [[
	libass/(
		ass.c ass_cache.c ass_font.c ass_fontselect.c ass_render.c
		ass_utils.c ass_bitmap.c ass_blur.c ass_library.c
		ass_drawing.c
		ass_parse.c ass_render_api.c ass_shaper.c
		ass_strtod.c ass_fontconfig.c
		ass_string.c
		ass_rasterizer.c ass_rasterizer_c.c
		x86/(
			blend_bitmaps.asm blur.asm cpuid.asm utils.asm
			be_blur.asm
			rasterizer.asm
		)
	)
	$builddir/pkg/(
		freetype/libfreetype.a.d
		fribidi/libfribidi.a
	)
]])

fetch 'git'
