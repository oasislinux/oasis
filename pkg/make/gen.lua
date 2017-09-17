cflags{
	'-D HAVE_CONFIG_H',
	'-I include',
	'-I $dir',
	'-I $srcdir',
	'-I $srcdir/glob',
}

lib('libglob.a', {'glob/glob.c', 'glob/fnmatch.c'})

exe('make', [[
	ar.c arscan.c commands.c default.c dir.c expand.c file.c
	function.c getopt.c getopt1.c guile.c implicit.c job.c load.c
	loadapi.c main.c misc.c posixos.c output.c read.c remake.c
	rule.c signame.c strcache.c variable.c version.c vpath.c
	hash.c remote-stub.c
	libglob.a
]])
file('bin/make', '755', '$outdir/make')
man{'make.1'}

fetch 'git'
