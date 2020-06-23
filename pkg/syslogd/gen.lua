cflags{'-std=c11', '-Wall', '-Wextra', '-Wpedantic'}

file('bin/syslogd', '755', exe('syslogd', {'syslogd.c'}))

fetch 'git'
