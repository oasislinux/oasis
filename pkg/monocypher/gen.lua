cflags{'-std=c99', '-Wall', '-Wextra', '-Wpedantic'}

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/src', {'monocypher.h'}),
	install=true,
}

lib('libmonocypher.a', {'src/monocypher.c'})
file('lib/libmonocypher.a', '644', '$outdir/libmonocypher.a')

fetch 'git'
