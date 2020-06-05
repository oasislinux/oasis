cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $outdir/include',
	'-isystem $builddir/pkg/zlib/include',
}

build('awk', '$outdir/pnglibconf.tf4', {
	'$srcdir/pngconf.h',
	'$srcdir/scripts/pnglibconf.dfa',
	'$srcdir/pngusr.dfa',
	'|', '$srcdir/scripts/options.awk',
}, {expr='-f $srcdir/scripts/options.awk out=/dev/stdout version=search'})
build('awk', '$outdir/pnglibconf.c', '$outdir/pnglibconf.tf4', {
	expr='-f $srcdir/scripts/options.awk out=/dev/stdout',
})
build('cpp', '$outdir/pnglibconf.tf1', {'$outdir/pnglibconf.c', '||', 'pkg/zlib/headers'})
build('awk', '$outdir/include/pnglibconf.h', '$outdir/pnglibconf.tf1', {
	expr='-f $srcdir/scripts/dfn.awk out=/dev/stdout',
})

pkg.hdrs = {
	copy('$outdir/include', '$srcdir', {'png.h', 'pngconf.h'}),
	'$outdir/include/pnglibconf.h',
	install=true,
}
pkg.deps = {'$outdir/include/pnglibconf.h', 'pkg/zlib/headers'}

lib('libpng.a', [[
	png.c pngerror.c
	pngget.c pngmem.c pngpread.c pngread.c pngrio.c pngrtran.c pngrutil.c
	pngset.c pngtrans.c pngwio.c pngwrite.c pngwtran.c pngwutil.c
	@aarch64 arm/(arm_init.c filter_neon.S filter_neon_intrinsics.c palette_neon_intrinsics.c)
	@x86_64 intel/(intel_init.c filter_sse2_intrinsics.c)
	$builddir/pkg/zlib/libz.a
]])
file('lib/libpng.a', '644', '$outdir/libpng.a')

fetch 'git'
