cflags{
	'-D FUSE_USE_VERSION=31',
	'-I $dir',
	'-I $basedir/pkg/fuse/src/include',
}

exe('sshfs', {
	'sshfs.c', 'nocache.c', '$builddir/pkg/fuse/libfuse.a',
}, {'pkg/fuse/fetch'})
file('bin/sshfs', '755', '$outdir/sshfs')
man{'$dir/sshfs.1'}

fetch 'git'
