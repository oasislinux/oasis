cflags{
	'-std=c11', '-Wall', '-Wextra', '-Wpedantic',
	([[-D 'PREFIX="%s"']]):format(config.prefix),
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.deps = {'pkg/linux-headers/headers'}

file('bin/hotplugd',             '755', exe('hotplugd',         {'hotplugd.c'}))
file('libexec/hotplugd-trigger', '755', exe('hotplugd-trigger', {'hotplugd-trigger.c'}))

fetch 'git'
