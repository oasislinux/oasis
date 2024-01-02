cflags{
	'-std=c99', '-Wall', '-Wpedantic', '-Wno-overflow',
	'-D _POSIX_C_SOURCE=201112L',
	'-I $srcdir/include',
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.deps = {'pkg/linux-headers/headers'}

pkg.hdrs = copy('$outdir/include/tinyalsa', '$srcdir/include/tinyalsa', {
	'attributes.h',
	'pcm.h',
	'mixer.h',
	'asoundlib.h',
	'version.h',
})

lib('libtinyalsa.a', [[
	src/(
		limits.c
		pcm.c
		pcm_hw.c
		mixer.c
		mixer_hw.c
	)
]])

for _, tool in ipairs{'tinycap', 'tinymix', 'tinypcminfo', 'tinyplay'} do
	file('bin/'..tool, '755', exe(tool, {'utils/'..tool..'.c', 'libtinyalsa.a'}))
	man{'utils/'..tool..'.1'}
end

fetch 'git'
