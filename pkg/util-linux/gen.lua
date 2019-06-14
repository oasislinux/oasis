set('version', '2.34.0')
cflags{
	'-include $dir/config.h',
	'-I $dir',
	'-I $outdir',
	'-I $srcdir/include',
	'-I $srcdir/libuuid/src',
}

build('sed', '$outdir/libsmartcols.h', '$srcdir/libsmartcols/src/libsmartcols.h.in', {
	expr='s,@LIBSMARTCOLS_VERSION@,$version,',
})
build('sed', '$outdir/libfdisk.h', '$srcdir/libfdisk/src/libfdisk.h.in', {
	expr={
		'-e s,@LIBFDISK_VERSION@,$version,',
		'-e /@LIBFDISK_MAJOR_VERSION@/d',
		'-e /@LIBFDISK_MINOR_VERSION@/d',
		'-e /@LIBFDISK_PATCH_VERSION@/d',
	},
})

pkg.hdrs = copy('$outdir/include/uuid', '$srcdir/libuuid/src', {'uuid.h'})
pkg.deps = {
	'$outdir/libsmartcols.h',
	'$outdir/libfdisk.h',
}

lib('libcommon.a', [[
	lib/(
		blkdev.c
		canonicalize.c
		crc32.c
		crc32c.c
		env.c
		idcache.c
		fileutils.c
		ismounted.c
		mangle.c
		match.c
		mbsalign.c
		md5.c
		pager.c
		pwdutils.c
		randutils.c
		setproctitle.c
		strutils.c
		timeutils.c
		ttyutils.c
		exec_shell.c
		strv.c
		sha1.c
		signames.c

		linux_version.c
		loopdev.c

		cpuset.c

		path.c
		procutils.c
		sysfs.c
	)
]])

lib('libfdisk.a', [[
	libfdisk/src/(
		init.c
		field.c
		item.c
		test.c
		ask.c
		alignment.c
		label.c
		utils.c
		context.c
		parttype.c
		partition.c
		table.c
		iter.c
		script.c
		version.c
		wipe.c

		sun.c
		sgi.c
		dos.c
		bsd.c
		gpt.c
	)
	libuuid.a libcommon.a
]])

lib('libsmartcols.a', [[
	libsmartcols/src/(
		iter.c
		symbols.c
		cell.c
		column.c
		line.c
		table.c
		print.c
		fput.c
		print-api.c
		version.c
		buffer.c
		calculate.c
		grouping.c
		walk.c
		init.c
	)
	libtcolors.a
	libcommon.a
]])

lib('libtcolors.a', 'lib/(colors.c color-names.c)')

lib('libuuid.a', [[
	libuuid/src/(
		clear.c
		compare.c
		copy.c
		gen_uuid.c
		isnull.c
		pack.c
		parse.c
		unpack.c
		unparse.c
		uuid_time.c
		predefined.c
	)
	libcommon.a
]])

exe('fdisk', [[
	disk-utils/(fdisk.c fdisk-menu.c fdisk-list.c)
	libfdisk.a.d libsmartcols.a.d
]])
file('bin/fdisk', '755', '$outdir/fdisk')
man{'disk-utils/fdisk.8'}

exe('losetup', [[
	sys-utils/losetup.c
	libsmartcols.a.d libcommon.a
]])
file('bin/losetup', '755', '$outdir/losetup')
man{'sys-utils/losetup.8'}

fetch 'git'
