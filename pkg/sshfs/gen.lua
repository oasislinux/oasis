cflags{
	'-D FUSE_USE_VERSION=31',
	'-I $dir',
	'-I pkg/libfuse/src/include',
}

build('sed', '$outdir/sshfs.1', '$srcdir/sshfs.1.in', {
	expr={
		[[-e 's,@UNMOUNT_COMMAND@,fusermount3 -u,']],
		[[-e 's,@IDMAP_DEFAULT@,"none",']],
	},
})

exe('sshfs', {
	'sshfs.c', 'nocache.c', '$builddir/pkg/libfuse/libfuse.a',
}, {'$builddir/pkg/libfuse/fetch.stamp'})
file('bin/sshfs', '755', '$outdir/sshfs')
man{'$outdir/sshfs.1'}

fetch 'git'
