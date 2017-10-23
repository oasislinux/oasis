cflags{
	'-D NDEBUG',
	'-Wall',
	'-Wno-maybe-uninitialized',
	'-D FZ_ENABLE_JS=0',
	-- HTML and EPUB require harfbuzz
	'-D FZ_ENABLE_HTML=0',
	'-D FZ_ENABLE_EPUB=0',
	-- JPX requires openjpeg
	'-D FZ_ENABLE_JPX=0',
	'-D NOTO_SMALL',
	'-D NOCJK',
	'-D SHARE_JPEG',
	'-I $srcdir/include',
	'-I $outdir',
	'-I pkg/freetype/src/include',
	'-I pkg/jbig2dec/src',
	'-I $builddir/pkg/libjpeg-turbo/include',
	'-I $builddir/pkg/zlib/include',
}

sub('tools.ninja', function()
	toolchain 'host'
	cflags{'-Wall'}

	exe('namedump', {'scripts/namedump.c'})
	exe('hexdump', {'scripts/hexdump.c'})
end)

rule('namedump', '$outdir/namedump $in $out')
build('namedump', {'$outdir/mupdf/pdf/name-table.h', '$outdir/pdf-name-table.h'}, {
	'$srcdir/resources/pdf/names.txt', '|', '$outdir/namedump',
})

rule('hexdump', '$outdir/hexdump -p $srcdir/ $out.tmp $in && mv $out.tmp $out')
local fonts = lines('fonts.txt')
for _, font in ipairs(fonts) do
	build('hexdump', '$outdir/'..font..'.c', {'$srcdir/resources/fonts/'..font, '|', '$outdir/hexdump'})
end

pkg.deps = {
	'$outdir/mupdf/pdf/name-table.h',
	'pkg/curl/headers',
	'pkg/freetype/fetch',
	'pkg/jbig2dec/fetch',
	'pkg/libjpeg-turbo/headers',
	'pkg/zlib/headers',
}

lib('libmupdf.a', {
	expand{'source/', lines('sources.txt')},
	expand{'$outdir/', fonts, '.c'},
	'$builddir/pkg/freetype/libfreetype.a.d',
	'$builddir/pkg/jbig2dec/libjbig2dec.a',
	'$builddir/pkg/libjpeg-turbo/libjpeg-turbo.a',
	'$builddir/pkg/zlib/libz.a',
})

exe('bin/mutool', [[
	source/tools/(
		mutool.c muconvert.c mudraw.c murun.c
		pdfclean.c pdfcreate.c pdfextract.c pdfinfo.c pdfmerge.c pdfpages.c
		pdfportfolio.c pdfposter.c pdfshow.c
	)
	libmupdf.a.d
]])
file('bin/mutool', '755', '$outdir/bin/mutool')

cc('platform/x11/curl_stream.c', {'pkg/curl/headers'}, {
	cflags='$cflags -I $builddir/pkg/curl/include',
})
cc('platform/x11/wl_main.c', {
	'$dir/deps',
	'pkg/libxkbcommon/fetch',
	'pkg/pixman/headers',
	'pkg/wayland/headers',
	'pkg/wayland-protocols/headers',
}, {cflags={
	'$cflags',
	'-I $builddir/pkg/pixman/include',
	'-I $builddir/pkg/wayland/include',
	'-I $builddir/pkg/wayland-protocols/include',
	'-I pkg/libxkbcommon/src',
}})
exe('bin/mupdf', [[
	platform/x11/(pdfapp.c curl_stream.c.o wl_main.c.o)
	libmupdf.a.d
	$builddir/pkg/(
		curl/libcurl.a.d
		jbig2dec/libjbig2dec.a
		libxkbcommon/libxkbcommon.a
		pixman/libpixman.a
		wayland-protocols/xdg-shell-unstable-v5-protocol.c.o
		wayland/libwayland-client.a.d
		wayland/libwayland-cursor.a
	)
]])
file('bin/mupdf', '755', '$outdir/bin/mupdf')

man{'docs/man/mutool.1', 'docs/man/mupdf.1'}

fetch 'git'
