cflags{
	'-std=c99', '-Wall', '-Wpedantic', '-Wno-maybe-uninitialized',
	'-isystem $builddir/pkg/b3sum/include',
}

lib('libcommon.a', {'fatal.c', 'parse.c', 'reallocarray.c'})

exe('fspec-hash', {'fspec-hash.c', 'libcommon.a', '$builddir/pkg/b3sum/libblake3.a'}, {'pkg/b3sum/headers'})
exe('fspec-sort', {'fspec-sort.c', 'libcommon.a'})
exe('fspec-tar', {'fspec-tar.c', 'libcommon.a'})

fetch 'git'
