cflags{
	'-std=c99', '-Wall', '-Wpedantic', '-Wno-maybe-uninitialized',
	'-isystem $builddir/pkg/b3sum/include',
}

sub('host.ninja', function()
	set('outdir', '$outdir/host')
	toolchain(config.host)
	cflags{'-isystem $builddir/pkg/b3sum/include'}

	lib('libcommon.a', {'fatal.c', 'parse.c', 'reallocarray.c'})
	exe('fspec-hash', {'fspec-hash.c', 'libcommon.a', '$builddir/pkg/b3sum/host/libblake3.a'}, {'pkg/b3sum/headers'})
	exe('fspec-sort', {'fspec-sort.c', 'libcommon.a'})
	exe('fspec-tar', {'fspec-tar.c', 'libcommon.a'})
end)

lib('libcommon.a', {'fatal.c', 'parse.c', 'reallocarray.c'})

exe('fspec-hash', {'fspec-hash.c', 'libcommon.a', '$builddir/pkg/b3sum/libblake3.a'}, {'pkg/b3sum/headers'})
file('bin/fspec-hash', '755', '$outdir/fspec-hash')

exe('fspec-sort', {'fspec-sort.c', 'libcommon.a'})
file('bin/fspec-sort', '755', '$outdir/fspec-sort')

exe('fspec-tar', {'fspec-tar.c', 'libcommon.a'})
file('bin/fspec-tar', '755', '$outdir/fspec-tar')

fetch 'git'
