for font in iterpaths[[ter-u(12 14 16 20 22 24 28 32)(n b).bdf]] do
	local srcs = {
		'$srcdir/uni/x11gr.uni', '$srcdir/uni/10646-1.uni',
		'|', '$dir/ucstoany.awk', '$srcdir/'..font,
	}
	build('awk', '$outdir/'..font, srcs, {
		expr='-v font=$srcdir/'..font..' -v charset=ISO10646-1 -f $dir/ucstoany.awk',
	})
	file('share/fonts/terminus/'..font, '644', '$outdir/'..font)
end

fetch 'curl'
