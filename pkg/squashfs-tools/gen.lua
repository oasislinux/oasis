cflags{
	'-Wall',
	'-D _GNU_SOURCE',
	'-D REPRODUCIBLE_DEFAULT',
	'-D GZIP_SUPPORT',
	'-D ZSTD_SUPPORT',
	[[-D 'COMP_DEFAULT="zstd"']],
}

cc('squashfs-tools/gzip_wrapper.c', {'pkg/zlib/headers'}, {
	cflags='$cflags -I $builddir/pkg/zlib/include',
})

cc('squashfs-tools/zstd_wrapper.c', {'$basedir/pkg/zstd/fetch'}, {
	cflags='$cflags -I $basedir/pkg/zstd/src/lib -I $basedir/pkg/zstd/src/lib/common'
})

objects([[squashfs-tools/(swap.c compressor.c)]])

exe('mksquashfs', [[
	squashfs-tools/(
		mksquashfs.c read_fs.c action.c swap.c.o pseudo.c compressor.c.o
		sort.c progressbar.c read_file.c info.c restore.c process_fragments.c
		caches-queues-lists.c

		gzip_wrapper.c.o
		zstd_wrapper.c.o
	)
	$builddir/pkg/zlib/libz.a
	$builddir/pkg/zstd/libzstd.a
]])
file('bin/mksquashfs', '755', '$outdir/mksquashfs')

exe('unsquashfs', [[
	squashfs-tools/(
		unsquashfs.c unsquash-1.c unsquash-2.c unsquash-3.c
		unsquash-4.c unsquash-123.c unsquash-34.c swap.c.o compressor.c.o unsquashfs_info.c

		gzip_wrapper.c.o
		zstd_wrapper.c.o
	)
	$builddir/pkg/zlib/libz.a
	$builddir/pkg/zstd/libzstd.a
]])
file('bin/unsquashfs', '755', '$outdir/unsquashfs')

fetch 'git'
