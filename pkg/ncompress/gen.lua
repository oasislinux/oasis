cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-D _POSIX_C_SOURCE=200809L',
	'-D UTIME_H',
	'-D LSTAT',
	'-D USERMEM=800000',
}

exe('lzw', {'compress.c'})
file('bin/lzw', '755', '$outdir/lzw')

fetch 'git'
