cflags{
	'-Wall',
	'-D POSIX',
	'-I $srcdir',
}

lib('libutp.a', {'utp.c', 'utp_utils.c'})

fetch 'git'
