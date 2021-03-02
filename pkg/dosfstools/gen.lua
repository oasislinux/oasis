set('version', '4.2')
cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-Wno-address-of-packed-member', '-Wno-overflow', -- ioctl
	'-D _GNU_SOURCE',
	'-include $dir/config.h',
	'-I $dir',
	'-I $srcdir/src/blkdev',
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.deps = {
	'pkg/linux-headers/headers',
}

lib('libcommon.a', [[src/(common.c charconv.c)]])

exe('mkfs.fat', [[
	src/(mkfs.fat.c device_info.c blkdev/(blkdev.c linux_version.c))
	libcommon.a
]])
file('bin/mkfs.fat', '755', '$outdir/mkfs.fat')

exe('fsck.fat', [[
	src/(fsck.fat.c check.c file.c lfn.c boot.c fat.c io.c)
	libcommon.a
]])
file('bin/fsck.fat', '755', '$outdir/fsck.fat')

for _, src in ipairs{'fsck.fat.8', 'mkfs.fat.8'} do
	local out = '$outdir/'..src
	build('sed', out, '$srcdir/manpages/'..src..'.in', {
		expr='s,@PACKAGE_VERSION@,$version,',
	})
	man{out}
end

fetch 'git'
