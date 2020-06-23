cflags{
	'-std=c11', '-Wall', '-Wextra', '-Wpedantic',
	([[-D 'PREFIX="%s"']]):format(config.prefix),
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.deps = {'pkg/linux-headers/headers'}

file('bin/devd',             '755', exe('devd',         {'devd.c'}))
file('libexec/devd-trigger', '755', exe('devd-trigger', {'devd-trigger.c'}))

fetch 'git'
