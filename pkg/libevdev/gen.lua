cflags{
	'-I $dir',
	'-I $outdir',
	'-I $srcdir/include',
}

pkg.hdrs = copy('$outdir/include/libevdev', '$srcdir/libevdev', {'libevdev.h'})
pkg.hdrs.install = true

build('awk', '$outdir/event-names.h', {
	'$srcdir/include/linux/input.h',
	'$srcdir/include/linux/input-event-codes.h',
	'|', '$dir/eventnames.awk',
}, {expr='-f $dir/eventnames.awk'})
lib('libevdev.a', {'libevdev/libevdev.c', 'libevdev/libevdev-names.c'}, {'$outdir/event-names.h'})
file('lib/libevdev.a', '644', '$outdir/libevdev.a')

fetch 'git'
