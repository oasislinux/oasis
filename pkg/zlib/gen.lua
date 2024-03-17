cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-D HAVE_STDARG_H',
	'-D HAVE_UNISTD_H',
	'-D _LARGEFILE64_SOURCE',
}

lib('libz.a', {
	'adler32.c',
	'crc32.c',
	'deflate.c',
	'infback.c',
	'inffast.c',
	'inflate.c',
	'inftrees.c',
	'trees.c',
	'zutil.c',

	'compress.c',
	'uncompr.c',
	'gzclose.c',
	'gzlib.c',
	'gzread.c',
	'gzwrite.c',
})
file('lib/libz.a', '644', '$outdir/libz.a')

pkg.hdrs = copy('$outdir/include', '$srcdir', {'zlib.h', 'zconf.h'})
pkg.hdrs.install = true

fetch 'git'
