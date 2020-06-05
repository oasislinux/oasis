set('srcdir', '$dir')
cflags{
	'-std=c11', '-Wall', '-Wextra', '-Wpedantic', '-Wno-unused-parameter',
}

cc('devd.c', 'pkg/linux-headers/headers', {cflags={
	'$cflags',
	'-isystem $builddir/pkg/linux-headers/include',
	string.format([[-D 'PREFIX="%s"']], config.prefix),
}})

file('libexec/applyperms',   '755', exe('applyperms',   {'applyperms.c'}))
file('libexec/devd-trigger', '755', exe('devd-trigger', {'devd-trigger.c'}))
file('libexec/mergeperms',   '755', exe('mergeperms',   {'mergeperms.c'}))
file('libexec/shutdown',     '755', exe('shutdown',     {'shutdown.c'}))
file('bin/devd',             '755', exe('devd',         {'devd.c.o'}))
file('bin/syslogd',          '755', exe('syslogd',      {'syslogd.c'}))
