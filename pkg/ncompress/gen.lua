cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-D _POSIX_C_SOURCE=200809L',
	'-include $dir/config.h',
}

exe('lzw', {'compress42.c'})
file('bin/lzw', '755', '$outdir/lzw')

fetch 'git'
