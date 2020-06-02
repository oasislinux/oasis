cflags{
	'-Wall',
	'-D HAVE_STDINT_H',
	'-D HAVE_GETOPT_H',
}

pkg.hdrs = copy('$outdir/include', '$srcdir', {'jbig2.h'})

lib('libjbig2dec.a', [[
	jbig2_arith.c jbig2_arith_int.c jbig2_arith_iaid.c
	jbig2_huffman.c jbig2_hufftab.c jbig2_segment.c jbig2_page.c
	jbig2_symbol_dict.c jbig2_text.c jbig2_halftone.c jbig2_generic.c
	jbig2_refinement.c jbig2_mmr.c jbig2_image.c jbig2.c
]])

fetch 'git'
