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
	'blocks.c',
	'buffer.c',
	'cmark.c',
	'cmark_ctype.c',
	'commonmark.c',
	'houdini_href_e.c',
	'houdini_html_e.c',
	'houdini_html_u.c',
	'html.c',
	'inlines.c',
	'iterator.c',
	'latex.c',
	'man.c',
	'node.c',
	'references.c',
	'render.c',
	'scanners.c',
	'utf8.c',
	'xml.c',
}})
file('lib/libcmark.a', '644', '$outdir/libcmark.a')

exe('cmark', {'src/main.c', 'libcmark.a'})
file('bin/cmark', '755', '$outdir/cmark')
man{'man/man1/cmark.1'}

fetch 'git'
