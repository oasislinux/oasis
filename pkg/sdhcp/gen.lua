cflags{
	'-std=c99', '-Wall', '-Wextra', '-Wpedantic',
	'-D _BSD_SOURCE',
}

exe('sdhcp', {'sdhcp.c', 'util/eprintf.c'})
file('bin/sdhcp', '755', '$outdir/sdhcp')
man{'sdhcp.1'}

fetch 'git'
