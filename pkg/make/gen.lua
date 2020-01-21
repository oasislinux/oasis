cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $srcdir/src',
	'-I $srcdir/lib',
	'-I $outdir',
}

build('copy', '$outdir/fnmatch.h', '$srcdir/lib/fnmatch.in.h')
build('copy', '$outdir/glob.h', '$srcdir/lib/glob.in.h')

pkg.deps = {
	'$outdir/fnmatch.h',
	'$outdir/glob.h',
}

lib('libgnu.a', [[
	lib/(
		concat-filename.c exitfail.c findprog-in.c fnmatch.c
		glob.c xalloc-die.c xconcat-filename.c
	)
]])

exe('make', [[
	src/(
		ar.c arscan.c commands.c
		default.c dir.c expand.c
		file.c function.c getopt.c
		getopt1.c guile.c
		hash.c implicit.c job.c
		load.c loadapi.c main.c misc.c
		output.c read.c remake.c
		rule.c signame.c strcache.c
		variable.c version.c vpath.c

		posixos.c
		remote-stub.c
	)
	libgnu.a
]])
file('bin/make', '755', '$outdir/make')
man{'make.1'}

fetch 'curl'
