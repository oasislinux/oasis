set('version', '2.30.2')
cflags{
	'-include $dir/config.h',
	'-I include',
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

pkg.deps = {
	'$outdir/libsmartcols.h',
	'$outdir/libfdisk.h',
}

lib('libcommon.a', [[
	lib/(
		blkdev.c
		canonicalize.c
		crc32.c
		env.c
		idcache.c
		fileutils.c
		ismounted.c
		mangle.c
		match.c
		mbsalign.c
		md5.c
		pager.c
		path.c
		randutils.c
		setproctitle.c
		strutils.c
		timeutils.c
		ttyutils.c
		exec_shell.c
		strv.c

		linux_version.c
		loopdev.c

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
		table_print.c
		version.c
		init.c
	)
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
	)
]])

exe('fdisk', [[
	disk-utils/(fdisk.c fdisk-menu.c fdisk-list.c)
	libfdisk.a.d libsmartcols.a libtcolors.a
]])
file('bin/fdisk', '755', '$outdir/fdisk')
man{'disk-utils/fdisk.8'}

fetch 'git'
