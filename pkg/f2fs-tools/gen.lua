cflags{
	'-Wall',
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $srcdir/include',
	'-I $builddir/pkg/util-linux/include',
}

pkg.deps = {
	'pkg/util-linux/headers',
}

lib('libf2fs.a', 'lib/(libf2fs.c libf2fs_io.c libf2fs_zoned.c nls_utf8.c)')

exe('mkfs.f2fs', [[
	mkfs/(f2fs_format_main.c f2fs_format.c f2fs_format_utils.c)
	libf2fs.a
	$builddir/pkg/util-linux/libuuid.a.d
]])
file('bin/mkfs.f2fs', '755', '$outdir/mkfs.f2fs')
man{'man/mkfs.f2fs.8'}

exe('fsck.f2fs', [[
	fsck/(
		main.c fsck.c dump.c mount.c defrag.c resize.c
		node.c segment.c dir.c sload.c xattr.c
		dict.c mkquota.c quotaio.c quotaio_tree.c quotaio_v2.c
	)
	libf2fs.a
]])
file('bin/fsck.f2fs', '755', '$outdir/fsck.f2fs')
man{'man/fsck.f2fs.8'}

fetch 'git'
