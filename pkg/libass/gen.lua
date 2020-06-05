cflags{
	'-I $dir',
	'-isystem $builddir/pkg/freetype/include',
	'-isystem $builddir/pkg/fribidi/include',
}
nasmflags{
	'-D ARCH_X86_64=1',
	'-D HAVE_ALIGNED_STACK=1',
	'-D HAVE_CPUNOP=0',
	'-D private_prefix=ass',
	'-i $srcdir/libass/',
	'-f elf64',
}
if config.target.pie then
	nasmflags{'-D PIC'}
end

pkg.hdrs = copy('$outdir/include/ass', '$srcdir/libass', {'ass.h', 'ass_types.h'})
pkg.deps = {
	'pkg/freetype/headers',
	'pkg/fribidi/headers',
}

lib('libass.a', [[
	libass/(
		ass.c ass_utils.c
		ass_string.c ass_strtod.c
		ass_library.c ass_cache.c
		ass_font.c ass_fontselect.c
		ass_render.c ass_render_api.c
		ass_parse.c ass_shaper.c
		ass_outline.c ass_drawing.c
		ass_rasterizer.c ass_rasterizer_c.c
		ass_bitmap.c ass_blur.c
		x86/(
			rasterizer.asm blend_bitmaps.asm blur.asm cpuid.asm
			be_blur.asm
		)
	)
	$builddir/pkg/freetype/libfreetype.a.d
	$builddir/pkg/fribidi/libfribidi.a
]])

fetch 'git'
