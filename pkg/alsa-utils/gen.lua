cflags{
	'-D _GNU_SOURCE=',
	'-I $dir',
	'-I $srcdir/include',
	'-I $builddir/pkg/alsa-lib/include',
}

pkg.deps = {'pkg/alsa-lib/headers'}

local tools = {
	{'amixer', {'amixer/amixer.c', 'alsamixer/volume_mapping.c'}},
	{'aplay', {'aplay/aplay.c'}},
}

for _, tool in ipairs(tools) do
	local name, srcs = table.unpack(tool)
	local out = 'bin/'..name
	exe(out, {srcs, '$builddir/pkg/alsa-lib/libasound.a'})
	file(out, '755', '$outdir/'..out)
	man{name..'/'..name..'.1'}
end

sym('bin/arecord', 'aplay')
sym('share/man/man1/arecord.1.gz', 'aplay.1.gz')

fetch 'git'
