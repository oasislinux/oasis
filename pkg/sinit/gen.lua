cflags{
	'-std=c99', '-Wall', '-Wextra',
	'-D _POSIX_C_SOURCE=200809L',
	string.format([[-D 'PREFIX="%s"']], config.prefix),
	'-I $dir',
}

file('bin/sinit', '755', exe('sinit', {'sinit.c'}))
sym('bin/init', 'sinit')
man{'sinit.8'}

fetch'git'
