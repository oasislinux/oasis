cflags{
	'-D _GNU_SOURCE=',
	'-I $dir',
	'-I $srcdir/include',
	'-I $builddir/pkg/alsa-lib/include',
}

pkg.deps = {'pkg/alsa-lib/headers'}

local function x(name, srcs)
	local out = 'bin/'..name
	exe(out, {srcs, '$builddir/pkg/alsa-lib/libasound.a'})
	file(out, '755', '$outdir/'..out)
	man{name..'/'..name..'.1'}
end

x('amixer', {'amixer/amixer.c', 'alsamixer/volume_mapping.c'})
x('aplay', {'aplay/aplay.c'})
sym('bin/arecord', 'aplay')
sym('share/man/man1/arecord.1.gz', 'aplay.1.gz')

fetch 'git'
