cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-I $dir',
}

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/src', {'cmark.h'}),
	copy('$outdir/include', '$dir', {'cmark_export.h', 'cmark_version.h'}),
	install=true,
}

lib('libcmark.a', expand{'src/', {
	'cmark.c',
	'node.c',
	'iterator.c',
	'blocks.c',
	'inlines.c',
	'scanners.c',
	'utf8.c',
	'buffer.c',
	'references.c',
	'render.c',
	'man.c',
	'xml.c',
	'html.c',
	'commonmark.c',
	'latex.c',
	'houdini_href_e.c',
	'houdini_html_e.c',
	'houdini_html_u.c',
	'cmark_ctype.c',
}})
file('lib/libcmark.a', '644', '$outdir/libcmark.a')

exe('cmark', {'src/main.c', 'libcmark.a'})
file('bin/cmark', '755', '$outdir/cmark')
man{'man/man1/cmark.1'}

fetch 'git'
