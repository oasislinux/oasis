cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-I $srcdir',
}

lib('libutp.a', {'utp.c', 'utp_utils.c'})

fetch 'git'
