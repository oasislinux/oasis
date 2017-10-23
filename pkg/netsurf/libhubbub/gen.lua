cflags{
	'-I $outdir',
	'-I $srcdir/src',
	'-I $srcdir/include',
	'-I pkg/netsurf/libdom/src/include',
	'-I pkg/netsurf/libparserutils/src/include',
	'-I pkg/netsurf/libwapcaplet/src/include',
}

build('awk', '$outdir/entities.inc', {'$srcdir/build/Entities', '|', '$dir/entities.awk'}, {
	expr='-f $dir/entities.awk',
})

pkg.deps = {
	'$outdir/entities.inc',
	'pkg/netsurf/libdom/fetch',
	'pkg/netsurf/libparserutils/fetch',
	'pkg/netsurf/libwapcaplet/fetch',
}

lib('libhubbub.a', [[src/(
	parser.c
	charset/detect.c
	tokeniser/(entities.c tokeniser.c)
	treebuilder/(
		treebuilder.c
		initial.c before_html.c before_head.c in_head.c
		in_head_noscript.c after_head.c in_body.c in_table.c
		in_caption.c in_column_group.c in_table_body.c in_row.c
		in_cell.c in_select.c in_select_in_table.c
		in_foreign_content.c after_body.c in_frameset.c
		after_frameset.c after_after_body.c after_after_frameset.c
		generic_rcdata.c
	)
	utils/(errors.c string.c)
) $builddir/pkg/netsurf/libparserutils/libparserutils.a]])

fetch 'git'
