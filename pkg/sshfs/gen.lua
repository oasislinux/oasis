cflags{
	'-D FUSE_USE_VERSION=31',
	'-I $dir',
	'-isystem $builddir/pkg/fuse/include',
}

pkg.deps = {'pkg/fuse/headers'}

exe('sshfs', {
	'sshfs.c',
	'nocache.c',
	'$builddir/pkg/fuse/libfuse.a',
})
file('bin/sshfs', '755', '$outdir/sshfs')
man{'$dir/sshfs.1'}

fetch 'git'
