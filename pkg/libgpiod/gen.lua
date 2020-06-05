cflags{
	'-std=c99', '-Wall', '-Wextra', '-Wpedantic',
	'-I $srcdir/include',
	'-isystem $builddir/pkg/linux-headers/include',
	'-include $dir/config.h',
}

pkg.deps = {
	'pkg/linux-headers/headers',
}

lib('libgpiod.a', 'lib/(core.c ctxless.c helpers.c iter.c misc.c)')

cc('tools/tools-common.c')
for _, tool in ipairs{'gpiodetect', 'gpioinfo', 'gpioget', 'gpioset', 'gpiomon', 'gpiofind'} do
	exe(tool, {'tools/'..tool..'.c', 'tools/tools-common.c.o', 'libgpiod.a'})
	file('bin/'..tool, '755', '$outdir/'..tool)
end

fetch 'git'
