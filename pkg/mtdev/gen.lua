cflags{
	'-I $srcdir/include',
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/include', {
	'mtdev.h',
	'mtdev-plumbing.h',
})
pkg.deps = {
	'pkg/linux-headers/headers',
}

lib('libmtdev.a', {
	'src/caps.c',
	'src/core.c',
	'src/iobuf.c',
	'src/match.c',
	'src/match_four.c',
})

fetch 'git'
