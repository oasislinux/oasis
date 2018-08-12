cflags{
	'-D _GNU_SOURCE',
	'-I $dir',
	'-I $builddir/pkg/pcre/include',
	'-I $builddir/pkg/zlib/include',
}

pkg.deps = {
	'pkg/pcre/headers',
	'pkg/zlib/headers',
}

exe('ag', [[
	src/(
	        ignore.c log.c options.c print.c print_w32.c scandir.c search.c lang.c
	        util.c decompress.c main.c
	)
	$builddir/pkg/(
		pcre/libpcre.a
		zlib/libz.a
	)
]])
file('bin/ag', '755', '$outdir/ag')
man{'doc/ag.1'}

fetch 'git'
