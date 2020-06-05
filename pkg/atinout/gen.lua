cflags{
	'-std=c99', '-Wall', '-Wextra', '-Wpedantic',
	'-Wno-implicit-fallthrough',
	[[-D 'VERSION="0.9.1"']],
}

exe('atinout', {'atinout.c'})
file('bin/atinout', '755', '$outdir/atinout')

fetch 'git'
