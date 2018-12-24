cflags{'-D NDEBUG'}

subgen 'libcss'
subgen 'libdom'
subgen 'libhubbub'
subgen 'libnsbmp'
subgen 'libnsgif'
subgen 'libnsutils'
subgen 'libparserutils'
subgen 'libsvgtiny'
subgen 'libwapcaplet'
subgen 'nsgenbind'

sub('tools.ninja', function()
	toolchain 'host'
	exe('convert_image', {'frontends/framebuffer/convert_image.c'}, {'pkg/libpng/headers'}, {
		ldlibs='-lpng -lz',
	})
end)

-- netsurf
cflags{
	'-include $dir/config.h',
	'-I $dir',
	'-I $srcdir',
	'-I $srcdir/include',
	'-I $srcdir/frontends',
	'-I $srcdir/content/handlers',
	'-I $outdir',
	'-I $outdir/libdom/include',
	'-I $builddir/pkg/curl/include',
	'-I $builddir/pkg/libjpeg-turbo/include',
	'-I $builddir/pkg/libpng/include',
	'-I $builddir/pkg/libressl/include',
	'-I $builddir/pkg/pixman/include',
	'-I $builddir/pkg/wayland/include',
	'-I $builddir/pkg/wayland-protocols/include',
	'-I $builddir/pkg/zlib/include',
	'-I $dir/libcss/src/include',
	'-I $dir/libdom/src/include',
	'-I $dir/libhubbub/src/include',
	'-I $dir/libnsbmp/src/include',
	'-I $dir/libnsgif/src/include',
	'-I $dir/libnsutils/src/include',
	'-I $dir/libparserutils/src/include',
	'-I $dir/libsvgtiny/src/include',
	'-I $dir/libwapcaplet/src/include',
	'-I pkg/freetype/src/include',
	'-I pkg/libxkbcommon/src',
	'-I pkg/openbsd/include',
	'-I pkg/utf8proc/src',
}

rule('nsgenbind', '$outdir/nsgenbind/nsgenbind -I $srcdir/content/handlers/javascript/WebIDL $in $outdir/duktape', {
	restat='1',
})

local nsgenbind = expand{'$outdir/duktape/', lines('nsgenbind.txt')}
build('nsgenbind', nsgenbind, {
	'$srcdir/content/handlers/javascript/duktape/netsurf.bnd',
	'|', '$outdir/nsgenbind/nsgenbind', '$dir/fetch',
})

pkg.deps = {
	'$dir/libcss/fetch',
	'$dir/libdom/fetch',
	'$dir/libdom/headers',
	'$dir/libhubbub/fetch',
	'$dir/libnsbmp/fetch',
	'$dir/libnsgif/fetch',
	'$dir/libnsutils/fetch',
	'$dir/libparserutils/fetch',
	'$dir/libsvgtiny/fetch',
	'$dir/libwapcaplet/fetch',
	'$outdir/duktape/binding.c',
	'pkg/curl/headers',
	'pkg/freetype/fetch',
	'pkg/libjpeg-turbo/headers',
	'pkg/libpng/headers',
	'pkg/libressl/headers',
	'pkg/libxkbcommon/fetch',
	'pkg/utf8proc/fetch',
	'pkg/zlib/headers',
}

local sources = {}
for _, src in ipairs(nsgenbind) do
	if src:hassuffix('.c') then
		table.insert(sources, src)
	end
end
exe('netsurf', {sources, paths[[
	desktop/(
		cookie_manager.c knockout.c hotlist.c mouse.c
		plot_style.c print.c search.c searchweb.c scrollbar.c
		sslcert_viewer.c textarea.c version.c system_colour.c
		local_history.c global_history.c treeview.c

		browser.c browser_history.c download.c frames.c netsurf.c
		save_complete.c save_text.c selection.c textinput.c gui_factory.c
		save_pdf.c font_haru.c
	)
	frontends/tiny/(download.c fetch.c icons.c gui.c render.c schedule.c ui.c wl.c)
	content/(
		content.c content_factory.c dirlist.c fetch.c hlcache.c
		llcache.c mimesniff.c urldb.c no_backing_store.c
		fetchers/(curl.c data.c file.c about.c resource.c)
		handlers/(
			image/(image.c image_cache.c bmp.c gif.c ico.c jpeg.c png.c svg.c)
			css/(css.c dump.c internal.c hints.c select.c utils.c)
			javascript/(fetcher.c content.c duktape/(dukky.c duktape.c))
			html/(
				box.c box_construct.c box_normalise.c box_textarea.c
				font.c form.c imagemap.c layout.c search.c table.c
				html.c html_css.c html_css_fetcher.c html_script.c
				html_interaction.c html_redraw.c html_redraw_border.c
				html_forms.c html_object.c
			)
			text/textplain.c
		)
	)
	utils/(
		bloom.c
		corestrings.c
		file.c
		filename.c
		filepath.c
		hashtable.c
		idna.c
		libdom.c
		log.c
		messages.c
		nsoption.c
		punycode.c
		talloc.c
		time.c
		url.c
		useragent.c
		utf8.c
		utils.c
		http/(
			challenge.c generics.c primitives.c parameter.c
			content-disposition.c content-type.c
			strict-transport-security.c www-authenticate.c
		)
		nsurl/(
			nsurl.c
			parse.c
		)
	)
	$outdir/(
		libcss/libcss.a.d
		libdom/libdom.a.d
		libnsbmp/libnsbmp.a
		libnsgif/libnsgif.a
		libnsutils/libnsutils.a
		libsvgtiny/libsvgtiny.a.d
	)
	$builddir/pkg/(
		curl/libcurl.a.d
		freetype/libfreetype.a.d
		libjpeg-turbo/libjpeg-turbo.a
		libpng/libpng.a
		libxkbcommon/libxkbcommon.a
		pixman/libpixman.a
		utf8proc/libutf8proc.a
		wayland/(libwayland-client.a.d libwayland-cursor.a)
		zlib/libz.a

		wayland-protocols/xdg-shell-protocol.c.o
	)
]]})
file('bin/netsurf', '755', '$outdir/netsurf')

build('sed', '$outdir/netsurf.1', '$srcdir/docs/netsurf-fb.1', {
	expr='s,netsurf-fb,netsurf,g',
})
man{'$outdir/netsurf.1'}

build('awk', '$outdir/Messages', {'$srcdir/resources/FatMessages', '|', '$dir/messages.awk'}, {
	expr='-f $dir/messages.awk -v lang=en -v filter=any',
})
file('share/netsurf/Messages', '644', '$outdir/Messages')

file('share/netsurf/SearchEngines', '644', '$srcdir/resources/SearchEngines')
file('share/netsurf/adblock.css', '644', '$srcdir/resources/adblock.css')
file('share/netsurf/credits.html', '644', '$srcdir/resources/en/credits.html')
file('share/netsurf/default.css', '644', '$srcdir/resources/default.css')
file('share/netsurf/favicon.png', '644', '$srcdir/resources/favicon.png')
file('share/netsurf/internal.css', '644', '$srcdir/resources/internal.css')
file('share/netsurf/licence.html', '644', '$srcdir/resources/en/licence.html')
sym('share/netsurf/maps.html', 'welcome.html')
file('share/netsurf/netsurf.png', '644', '$srcdir/resources/netsurf.png')
file('share/netsurf/quirks.css', '644', '$srcdir/resources/quirks.css')
file('share/netsurf/welcome.html', '644', '$srcdir/resources/en/welcome.html')
for icon in iterpaths[[back forward add remove home reload stop close up down]] do
	file('share/netsurf/icons/'..icon..'.ff', '644', '$srcdir/frontends/tiny/res/icons/'..icon..'.ff')
end

fetch 'git'
