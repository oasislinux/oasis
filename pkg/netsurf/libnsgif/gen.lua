cflags{'-I $srcdir/include'}
lib('libnsgif.a', {'src/libnsgif.c', 'src/lzw.c'})
fetch 'git'
