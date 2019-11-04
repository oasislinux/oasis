set('srcdir', '$dir')
cflags{
	'-Wall', '-Wextra', '-Wno-unused-parameter', '-pedantic',
	'-std=c11',
}

file('libexec/applyperms',   '755', exe('applyperms',   {'applyperms.c'}))
file('libexec/devd-trigger', '755', exe('devd-trigger', {'devd-trigger.c'}))
file('libexec/mergeperms',   '755', exe('mergeperms',   {'mergeperms.c'}))
file('libexec/shutdown',     '755', exe('shutdown',     {'shutdown.c'}))
file('bin/devd',             '755', exe('devd',         {'devd.c'}))
file('bin/syslogd',          '755', exe('syslogd',      {'syslogd.c'}))
