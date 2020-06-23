set('srcdir', '$dir')
cflags{
	'-std=c11', '-Wall', '-Wextra', '-Wpedantic', '-Wno-unused-parameter',
}

file('libexec/applyperms',   '755', exe('applyperms',   {'applyperms.c'}))
file('libexec/mergeperms',   '755', exe('mergeperms',   {'mergeperms.c'}))
file('libexec/shutdown',     '755', exe('shutdown',     {'shutdown.c'}))
file('bin/syslogd',          '755', exe('syslogd',      {'syslogd.c'}))
