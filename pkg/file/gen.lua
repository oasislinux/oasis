local version = '5.45'
cflags{
	'-Wall',
	'-Wno-maybe-uninitialized',  -- false positive in src/readelf.c
	'-D HAVE_CONFIG_H',
	([[-D 'MAGIC="%s/share/file/magic"']]):format(config.prefix),
	'-D _GNU_SOURCE',
	'-I $dir',
	'-I $outdir/include',
	'-isystem $builddir/pkg/zlib/include',
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
pkg.deps = {'$gendir/headers', 'pkg/zlib/headers'}

lib('libmagic.a', [[src/(
	buffer.c magic.c apprentice.c softmagic.c
	ascmagic.c encoding.c compress.c is_csv.c is_json.c
	is_simh.c is_tar.c readelf.c print.c fsmagic.c funcs.c
	apptype.c der.c cdf.c cdf_time.c readcdf.c fmtcheck.c
)]])

exe('file', {'src/file.c', 'src/seccomp.c', 'libmagic.a', '$builddir/pkg/zlib/libz.a'})
file('bin/file', '755', '$outdir/file')
man{'$outdir/file.1'}

sub('host.ninja', function()
	toolchain(config.host)
	cflags{
		'-I $outdir/include',
		'-D HAVE_STDINT_H',
		'-D HAVE_INTTYPES_H',
		'-D HAVE_UNISTD_H',
		'-D COMPILE_ONLY',
		([[-D 'VERSION="%s"']]):format(version),
	}
	set('outdir', '$outdir/host')
	exe('magic', 'src/(magic.c apprentice.c encoding.c print.c funcs.c cdf_time.c strlcpy.c)')
end)

rule('magic', 'cd $outdir && ./host/magic magic')
build('magic', '$outdir/magic.mgc', {'|',
	'$outdir/host/magic',
	copy('$outdir/magic', '$srcdir/magic/Magdir', lines('magic.txt')),
	copy('$outdir/magic', '$srcdir/magic', {'Header', 'Localstuff'}),
})
file('share/file/magic.mgc', '644', '$outdir/magic.mgc')

fetch 'git'
