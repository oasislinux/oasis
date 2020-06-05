set('version', '4.1')
cflags{
	'-include $dir/config.h',
	'-I $dir',
	'-I $srcdir/src/blkdev',
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.deps = {
	'pkg/linux-headers/headers',
}

exe('mkfs.fat', [[src/(mkfs.fat.c device_info.c blkdev/(blkdev.c linux_version.c))]])
file('bin/mkfs.fat', '755', '$outdir/mkfs.fat')

exe('fsck.fat', [[src/(fsck.fat.c boot.c check.c common.c fat.c file.c io.c lfn.c charconv.c)]])
file('bin/fsck.fat', '755', '$outdir/fsck.fat')

for _, src in ipairs{'fsck.fat.8', 'mkfs.fat.8'} do
	local out = '$outdir/'..src
	build('sed', out, '$srcdir/manpages/'..src..'.in', {
		expr='s,@PACKAGE_VERSION@,$version,',
	})
	man{out}
end

fetch 'git'
