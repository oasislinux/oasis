local version = '5.32'
cflags{
	'-Wall',
	'-D HAVE_CONFIG_H',
	[[-D 'MAGIC="/share/file/magic"']],
	'-D _GNU_SOURCE',
	'-I include',
	'-I $dir',
	'-I $outdir/include',
	'-I $builddir/pkg/zlib/include',
}

build('sed', '$outdir/include/magic.h', '$srcdir/src/magic.h.in', {
	expr='s,X.YY,'..version:gsub('%.', '')..',',
})

build('sed', '$outdir/file.1', '$srcdir/doc/file.man', {
	expr={
		'-e s,__CSECTION__,1,g',
		'-e s,__FSECTION__,5,g',
		'-e s,__VERSION__,'..version..',g',
		'-e s,__MAGIC__,/share/file/magic,g',
	},
})

pkg.hdrs = {'$outdir/include/magic.h'}
pkg.deps = {'$dir/headers', 'pkg/zlib/headers'}

lib('libmagic.a', [[src/(
	magic.c
	apprentice.c
	softmagic.c
	ascmagic.c
	encoding.c
	compress.c
	is_tar.c
	readelf.c
	print.c
	fsmagic.c
	funcs.c
	apptype.c
	der.c
	cdf.c
	cdf_time.c
	readcdf.c

	fmtcheck.c
)]])

exe('file', {'src/file.c', 'libmagic.a', '$builddir/pkg/zlib/libz.a'})
file('bin/file', '755', '$outdir/file')
man{'$outdir/file.1'}

rule('magic', 'cd $outdir && file -C -m magic')
build('magic', '$outdir/magic.mgc', {'|',
	copy('$outdir/magic', '$srcdir/magic/Magdir', lines('magic.txt')),
	copy('$outdir/magic', '$srcdir/magic', {'Header', 'Localstuff'}),
})
file('share/file/magic.mgc', '644', '$outdir/magic.mgc')

fetch 'git'
