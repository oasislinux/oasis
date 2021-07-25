cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-D _POSIX_C_SOURCE=200809L',
	string.format([[-D 'PREFIX="%s"']], config.prefix),
	'-I $dir',
}

file('bin/sinit', '755', exe('sinit', {'sinit.c'}))
sym('bin/init', 'sinit')
man{'sinit.8'}

build('cc', '$outdir/shutdown.c.o', '$dir/shutdown.c')
file('libexec/shutdown', '755', exe('shutdown', {'shutdown.c.o'}))

fetch'git'
