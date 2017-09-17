set('srcdir', '$dir')
cflags{
	'-Wall', '-Wextra', '-Wno-unused-parameter', '-pedantic',
	'-std=c11',
}

file('libexec/applyperms', '755', exe('applyperms', {'applyperms.c'}))
file('libexec/shutdown',   '755', exe('shutdown',   {'shutdown.c'}))
file('bin/syslogd',        '755', exe('syslogd',    {'syslogd.c'}))
