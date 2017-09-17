cflags{
	'-std=c99', '-pedantic', '-Wall', '-Wextra',
	'-D _DEFAULT_SOURCE',
	'-I $builddir/pkg/libjpeg-turbo/include',
	'-I $builddir/pkg/libpng/include',
}

cc('util.c')

exe('png2ff', {'png2ff.c', 'util.c.o', '$builddir/pkg/libpng/libpng.a.d'}, {'pkg/libpng/headers'})
exe('ff2png', {'ff2png.c', 'util.c.o', '$builddir/pkg/libpng/libpng.a.d'}, {'pkg/libpng/headers'})
exe('jpg2ff', {'jpg2ff.c', 'util.c.o', '$builddir/pkg/libjpeg-turbo/libjpeg-turbo.a'}, {'pkg/libjpeg-turbo/headers'})
exe('ff2jpg', {'ff2jpg.c', 'util.c.o', '$builddir/pkg/libjpeg-turbo/libjpeg-turbo.a'}, {'pkg/libjpeg-turbo/headers'})
exe('ff2pam', {'ff2pam.c', 'util.c.o'})
exe('ff2ppm', {'ff2ppm.c', 'util.c.o'})

for _, cmd in ipairs{'png2ff', 'ff2png', 'jpg2ff', 'ff2jpg', 'ff2pam', 'ff2ppm'} do
	file('bin/'..cmd, '755', '$outdir/'..cmd)
	man{cmd..'.1'}
end
man{'farbfeld.5'}

fetch 'git'
