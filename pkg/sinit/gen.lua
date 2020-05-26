cflags{
	'-Wall', '-Wextra',
	string.format([[-D 'PREFIX="%s"']], config.prefix),
	'-I $dir',
}

file('bin/sinit', '755', exe('sinit', {'sinit.c'}))
man{'sinit.8'}

fetch'git'
