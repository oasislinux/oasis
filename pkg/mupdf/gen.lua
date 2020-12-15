cflags{
	'-D NDEBUG',
	'-Wall', '-Wno-maybe-uninitialized', '-Wno-stringop-overflow', '-Wno-format-overflow',
	'-D FZ_ENABLE_JS=0',
	-- HTML and EPUB require harfbuzz
	'-D FZ_ENABLE_HTML=0',
	'-D FZ_ENABLE_EPUB=0',
	-- ICS requires lcms2
	'-D FZ_ENABLE_ICC=0',
	-- JPX requires openjpeg
	'-D FZ_ENABLE_JPX=0',
	'-D HAVE_PTHREAD',
	'-D NOTO_SMALL',
	'-D NO_CJK',
	'-D NO_ICC',
	'-D SHARE_JPEG',
	'-I $srcdir/include',
	'-I $outdir',
	'-isystem $builddir/pkg/freetype/include',
	'-isystem $builddir/pkg/jbig2dec/include',
	'-isystem $builddir/pkg/libjpeg-turbo/include',
	'-isystem $builddir/pkg/zlib/include',
}

sub('tools.ninja', function()
	toolchain(config.host)
	cflags{'-Wall'}
	exe('hexdump', {'scripts/hexdump.c'})
end)

rule('hexdump', '$outdir/hexdump -s $out $in')
local fonts = lines('fonts.txt')
for _, font in ipairs(fonts) do
	build('hexdump', '$outdir/'..font..'.c', {'$srcdir/resources/fonts/'..font, '|', '$outdir/hexdump'})
end

pkg.deps = {
	'pkg/freetype/headers',
	'pkg/jbig2dec/headers',
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
lib('libmupdf-threads.a', {
	'source/helpers/mu-threads/mu-threads.c',
})
lib('libmupdf-pkcs7.a', {
	'source/helpers/pkcs7/pkcs7-check.c',
	'source/helpers/pkcs7/pkcs7-openssl.c',
})

exe('bin/mutool', [[
	source/tools/(
		mutool.c muconvert.c mudraw.c murun.c mutrace.c cmapdump.c
		pdfclean.c pdfcreate.c pdfextract.c pdfinfo.c pdfmerge.c pdfpages.c
		pdfposter.c pdfshow.c pdfsign.c
	)
	libmupdf.a.d
	libmupdf-pkcs7.a
	libmupdf-threads.a
]])
file('bin/mutool', '755', '$outdir/bin/mutool')

cc('platform/x11/wl_main.c', {
	'$gendir/deps',
	'pkg/libxkbcommon/headers',
	'pkg/pixman/headers',
	'pkg/wayland/headers',
	'pkg/wayland-protocols/headers',
}, {cflags={
	'$cflags',
	'-isystem $builddir/pkg/libxkbcommon/include',
	'-isystem $builddir/pkg/pixman/include',
	'-isystem $builddir/pkg/wayland/include',
	'-isystem $builddir/pkg/wayland-protocols/include',
}})
exe('bin/mupdf', [[
	platform/x11/(pdfapp.c wl_main.c.o)
	libmupdf.a.d
	libmupdf-pkcs7.a
	$builddir/pkg/(
		jbig2dec/libjbig2dec.a
		libxkbcommon/libxkbcommon.a
		pixman/libpixman.a
		wayland-protocols/xdg-shell-protocol.c.o
		wayland/libwayland-client.a.d
		wayland/libwayland-cursor.a
	)
]])
file('bin/mupdf', '755', '$outdir/bin/mupdf')

man{'docs/man/mutool.1', 'docs/man/mupdf.1'}

fetch 'git'
