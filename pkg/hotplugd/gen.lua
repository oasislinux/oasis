cflags{
	'-std=c11', '-Wall', '-Wextra', '-Wpedantic',
	([[-D 'PREFIX="%s"']]):format(config.prefix),
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.deps = {'pkg/linux-headers/headers'}

file('bin/hotplugd',             '755', exe('hotplugd', {'hotplugd.c'}))
file('libexec/hotplugd/ata_id',  '755', exe('ata_id',   {'ata_id.c'}))
file('libexec/hotplugd/trigger', '755', exe('trigger',  {'trigger.c'}))

fetch 'git'
