cflags{
	'-D HAVE_EXPAT_CONFIG_H',
	'-I $dir',
	'-I $basedir/pkg/openbsd/include',
}

lib('libexpat.a', [[
	expat/lib/(xmlparse.c xmltok.c xmlrole.c)
	$builddir/pkg/openbsd/libbsd.a.d
]])

pkg.hdrs = copy('$outdir/include', '$srcdir/expat/lib', {
	'expat.h',
	'expat_external.h',
})

fetch 'git'
