cflags{
	'-D _GNU_SOURCE=',
	'-I $dir',
	'-I $srcdir/include',
	'-isystem $builddir/pkg/alsa-lib/include',
}

pkg.deps = {'pkg/alsa-lib/headers'}

exe('bin/amixer', {'amixer/amixer.c', 'alsamixer/volume_mapping.c', '$builddir/pkg/alsa-lib/libasound.a'})
file('bin/amixer', '755', '$outdir/bin/amixer')
man{'amixer/amixer.1'}

exe('bin/aplay', {'aplay/aplay.c', '$builddir/pkg/alsa-lib/libasound.a'})
file('bin/aplay', '755', '$outdir/bin/aplay')
man{'aplay/aplay.1'}

sym('bin/arecord', 'aplay')
sym('share/man/man1/arecord.1.gz', 'aplay.1.gz')

fetch 'git'
