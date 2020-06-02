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

sub('tools.ninja', function()
	toolchain(config.host)
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
	'-I $builddir/pkg/freetype/include',
	'-I $builddir/pkg/libjpeg-turbo/include',
	'-I $builddir/pkg/libpng/include',
	'-I $builddir/pkg/libxkbcommon/include',
	'-I $builddir/pkg/linux-headers/include',
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
	'-I $basedir/pkg/openbsd/include',
	'-I $basedir/pkg/utf8proc/src',
}

pkg.deps = {
	'$dir/libcss/fetch',
	'$dir/libdom/fetch',
	'$gendir/libdom/headers',
	'$dir/libhubbub/fetch',
	'$dir/libnsbmp/fetch',
	'$dir/libnsgif/fetch',
	'$dir/libnsutils/fetch',
	'$dir/libparserutils/fetch',
	'$dir/libsvgtiny/fetch',
	'$dir/libwapcaplet/fetch',
	'pkg/curl/headers',
	'pkg/freetype/headers',
	'pkg/libjpeg-turbo/headers',
	'pkg/libpng/headers',
	'pkg/libxkbcommon/headers',
	'pkg/linux-headers/headers',
	'pkg/pixman/headers',
	'pkg/utf8proc/fetch',
	'pkg/wayland/headers',
	'pkg/wayland-protocols/headers',
	'pkg/zlib/headers',
}

exe('netsurf', [[
	desktop/(
		cookie_manager.c knockout.c hotlist.c mouse.c
		plot_style.c print.c search.c searchweb.c scrollbar.c
		textarea.c version.c system_colour.c
		local_history.c global_history.c treeview.c page-info.c

		browser.c browser_window.c browser_history.c
		download.c frames.c netsurf.c cw_helper.c
		save_complete.c save_text.c selection.c textinput.c gui_factory.c
		save_pdf.c font_haru.c
	)
	frontends/tiny/(download.c fetch.c icons.c gui.c render.c schedule.c ui.c wl.c)
	content/(
		content.c
		content_factory.c
		dirlist.c
		fetch.c
		hlcache.c
		llcache.c
		mimesniff.c
		textsearch.c
		urldb.c
		no_backing_store.c
		fetchers/(curl.c data.c file.c about.c resource.c)
		handlers/(
			image/(image.c image_cache.c bmp.c gif.c ico.c jpeg.c png.c svg.c)
			css/(css.c dump.c internal.c hints.c select.c utils.c)
			javascript/(fetcher.c none/none.c)
			html/(
				box_construct.c
				box_inspect.c
				box_manipulate.c
				box_normalise.c
				box_special.c
				box_textarea.c
				css.c
				css_fetcher.c
				dom_event.c
				font.c
				form.c
				forms.c
				html.c
				imagemap.c
				interaction.c
				layout.c
				object.c
				redraw.c
				redraw_border.c
				script.c
				table.c
				textselection.c
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
		hashmap.c
		hashtable.c
		idna.c
		libdom.c
		log.c
		messages.c
		nscolour.c
		nsoption.c
		punycode.c
		ssl_certs.c
		talloc.c
		time.c
		url.c
		useragent.c
		utf8.c
		utils.c
		http/(
			challenge.c generics.c primitives.c parameter.c
			cache-control.c content-disposition.c content-type.c
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
]])
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
file('share/netsurf/netsurf.png', '644', '$srcdir/resources/netsurf.png')
file('share/netsurf/quirks.css', '644', '$srcdir/resources/quirks.css')
file('share/netsurf/welcome.html', '644', '$srcdir/resources/en/welcome.html')
for icon in iterpaths[[back forward add remove home reload stop close up down]] do
	file('share/netsurf/icons/'..icon..'.ff', '644', '$srcdir/frontends/tiny/res/icons/'..icon..'.ff')
end

fetch 'git'
