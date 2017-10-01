cflags{
	'-I $dir',
	'-I $srcdir/include',
	'-I $srcdir/src',
	'-I pkg/netsurf/libdom/src/include',
	'-I pkg/netsurf/libwapcaplet/src/include',
	'-I $builddir/pkg/netsurf/libdom/include',
}

pkg.deps = {
	'pkg/netsurf/libdom/headers',
	'$builddir/pkg/netsurf/libdom/fetch.stamp',
	'$builddir/pkg/netsurf/libwapcaplet/fetch.stamp',
}

lib('libsvgtiny.a', [[
	src/(svgtiny.c svgtiny_gradient.c svgtiny_list.c)
	$builddir/pkg/netsurf/libdom/libdom.a.d
]])

fetch 'git'
