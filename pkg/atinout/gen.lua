cflags{
	'-std=c99', '-Wall', '-Wextra', '-Wpedantic',
	[[-D 'VERSION="0.9.1"']],
}

exe('atinout', {'atinout.c'})
file('bin/atinout', '755', '$outdir/atinout')

fetch 'git'
