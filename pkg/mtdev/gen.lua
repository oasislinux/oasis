cflags{
	'-I $srcdir/include',
	'-I $builddir/pkg/linux-headers/include',
}

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
