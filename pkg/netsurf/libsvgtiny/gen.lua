cflags{
	'-I $dir',
	'-I $srcdir/include',
	'-I $srcdir/src',
	'-I $basedir/pkg/netsurf/libdom/src/include',
	'-I $basedir/pkg/netsurf/libwapcaplet/src/include',
	'-I $builddir/pkg/netsurf/libdom/include',
}

pkg.deps = {
	'pkg/netsurf/libdom/fetch',
	'pkg/netsurf/libdom/headers',
	'pkg/netsurf/libwapcaplet/fetch',
}

lib('libsvgtiny.a', [[
	src/(svgtiny.c svgtiny_gradient.c svgtiny_list.c)
	$builddir/pkg/netsurf/libdom/libdom.a.d
]])

fetch 'git'
