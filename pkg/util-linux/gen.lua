set('version', '2.37.0')
cflags{
	'-include $dir/config.h',
	'-I $outdir',
	'-I $srcdir/include',
	'-I $srcdir/libblkid/src',
	'-I $srcdir/libuuid/src',
	'-isystem $builddir/pkg/linux-headers/include',
}

build('cat', '$outdir/config.h', {
	'$builddir/probe/HAVE__THREAD_LOCAL',
	'$dir/config.h',
})

build('sed', '$outdir/libsmartcols.h', '$srcdir/libsmartcols/src/libsmartcols.h.in', {
	expr='s,@LIBSMARTCOLS_VERSION@,$version,',
})
build('sed', '$outdir/blkid.h', '$srcdir/libblkid/src/blkid.h.in', {
	expr={
		'-e /@LIBBLKID_VERSION@/d',
		'-e /@LIBBLKID_DATE@/d',
	},
})
build('sed', '$outdir/libfdisk.h', '$srcdir/libfdisk/src/libfdisk.h.in', {
	expr={
		'-e s,@LIBFDISK_VERSION@,$version,',
		'-e /@LIBFDISK_MAJOR_VERSION@/d',
		'-e /@LIBFDISK_MINOR_VERSION@/d',
		'-e /@LIBFDISK_PATCH_VERSION@/d',
	},
})

pkg.hdrs = {
	copy('$outdir/include/uuid', '$srcdir/libuuid/src', {'uuid.h'}),
	copy('$outdir/include/blkid', '$outdir', {'blkid.h'}),
}
pkg.deps = {
	'$outdir/config.h',
	'$outdir/libsmartcols.h',
	'$outdir/libfdisk.h',
	'pkg/linux-headers/headers',
}

lib('libcommon.a', [[
	lib/(
		blkdev.c
		buffer.c
		canonicalize.c
		crc32.c
		crc32c.c
		encode.c
		env.c
		fileutils.c
		idcache.c
		jsonwrt.c
		mangle.c
		match.c
		mbsalign.c
		md5.c
		pager.c
		pwdutils.c
		randutils.c
		sha1.c
		signames.c
		strutils.c
		strv.c
		timeutils.c
		ttyutils.c

		linux_version.c
		procutils.c
		loopdev.c

		cpuset.c

		path.c
		sysfs.c
	)
]])

lib('libblkid.a', [[
	libblkid/src/(
		init.c
		cache.c
		config.c
		dev.c
		devname.c
		devno.c
		encode.c
		evaluate.c
		getsize.c
		probe.c
		read.c
		resolve.c
		save.c
		tag.c
		verify.c
		version.c
		partitions/(
			aix.c
			atari.c
			bsd.c
			dos.c
			gpt.c
			mac.c
			minix.c
			partitions.c
			sgi.c
			solaris_x86.c
			sun.c
			ultrix.c
			unixware.c
		)
		superblocks/(
			adaptec_raid.c
			apfs.c
			bcache.c
			befs.c
			bfs.c
			bitlocker.c
			bluestore.c
			btrfs.c
			cramfs.c
			ddf_raid.c
			drbd.c
			drbdproxy_datalog.c
			drbdmanage.c
			exfat.c
			exfs.c
			ext.c
			f2fs.c
			gfs.c
			hfs.c
			highpoint_raid.c
			hpfs.c
			iso9660.c
			isw_raid.c
			jfs.c
			jmicron_raid.c
			linux_raid.c
			lsi_raid.c
			luks.c
			lvm.c
			minix.c
			mpool.c
			netware.c
			nilfs.c
			ntfs.c
			refs.c
			nvidia_raid.c
			ocfs.c
			promise_raid.c
			reiserfs.c
			romfs.c
			silicon_raid.c
			squashfs.c
			stratis.c
			superblocks.c
			swap.c
			sysv.c
			ubi.c
			ubifs.c
			udf.c
			ufs.c
			vdo.c
			vfat.c
			via_raid.c
			vmfs.c
			vxfs.c
			xfs.c
			zfs.c
			zonefs.c
			erofs.c
		)
		topology/(
			topology.c
			dm.c
			evms.c
			ioctl.c
			lvm.c
			md.c
			sysfs.c
		)
	)
	libcommon.a
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
	libuuid.a libblkid.a libcommon.a
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
man{'$dir/man/fdisk.8'}

exe('losetup', [[
	sys-utils/losetup.c
	libsmartcols.a.d libcommon.a
]])
file('bin/losetup', '755', '$outdir/losetup')
man{'$dir/man/losetup.8'}

fetch 'git'
