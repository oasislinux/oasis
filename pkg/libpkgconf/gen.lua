cflags{
	'-I $dir',
	'-I $srcdir',
}

pkg.hdrs = { 
	copy('$outdir/libpkgconf', '$srcdir/libpkgconf', {
		'libpkgconf.h',
		'bsdstubs.h',
		'stdinc.h',
		'libpkgconf-api.h',
		'iter.h',
	})}

lib('libpkgconf.a', [[libpkgconf/(
		audit.c cache.c client.c
		pkg.c bsdstubs.c fragment.c
		argvsplit.c fileio.c tuple.c
		dependency.c queue.c path.c
		personality.c parser.c
)]])

fetch 'git'
