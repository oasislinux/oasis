cflags{
	'-I $dir',
	'-I $outdir',
	'-I $srcdir/include',
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.hdrs = copy('$outdir/include/libevdev', '$srcdir/libevdev', {'libevdev.h'})
pkg.hdrs.install = true

pkg.deps = {
	'pkg/linux-headers/headers',
}

rule('eventnames', 'lua $dir/eventnames.lua $in >$out')
build('eventnames', '$outdir/event-names.h', {
	'$srcdir/include/linux/linux/input.h',
	'$srcdir/include/linux/linux/input-event-codes.h',
	'|', '$dir/eventnames.lua',
})
lib('libevdev.a', {'libevdev/libevdev.c', 'libevdev/libevdev-names.c'}, {'$outdir/event-names.h'})
file('lib/libevdev.a', '644', '$outdir/libevdev.a')

fetch 'git'
