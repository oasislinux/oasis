cflags{
	'-std=c99',
	'-Wall', '-Wpedantic', '-Wvla',
	'-D _GNU_SOURCE',
	'-I $dir',
}

build('awk', '$outdir/caps.h', {
	'$builddir/pkg/linux-headers/include/linux/capability.h',
	'|', '$dir/caps.awk',
}, {expr='-f $dir/caps.awk'})

build('cc', '$outdir/caps.c.o', {'$dir/caps.c', '|', '$outdir/caps.h'}, {cflags='-I $outdir'})

exe('bwrap', {
	'bubblewrap.c',
	'bind-mount.c',
	'network.c',
	'utils.c',
	'caps.c.o',
})
file('bin/bwrap', '755', '$outdir/bwrap')
man{'$dir/bwrap.1'}

fetch 'git'
