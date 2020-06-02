cflags{
	'-include $dir/config.h',
	'-I $srcdir',
	'-I $builddir/pkg/bzip2/include',
}

pkg.deps = {'pkg/bzip2/headers'}

exe('unzip', [[
        unzip.c crc32.c crypt.c envargs.c explode.c
	extract.c fileio.c globals.c inflate.c list.c match.c
	process.c ttyio.c ubz2err.c unreduce.c unshrink.c zipinfo.c
	unix/unix.c
	$builddir/pkg/bzip2/libbz2.a
]])
file('bin/unzip', '755', '$outdir/unzip')
man{'man/unzip.1'}

fetch 'curl'
