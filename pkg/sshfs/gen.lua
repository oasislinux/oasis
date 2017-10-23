cflags{
	'-D FUSE_USE_VERSION=31',
	'-I $dir',
	'-I pkg/libfuse/src/include',
}

exe('sshfs', {
	'sshfs.c', 'nocache.c', '$builddir/pkg/libfuse/libfuse.a',
}, {'pkg/libfuse/fetch'})
file('bin/sshfs', '755', '$outdir/sshfs')
man{'$dir/sshfs.1'}

fetch 'git'
