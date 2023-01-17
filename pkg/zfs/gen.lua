cflags{
	'-std=c99 -Wall',
	'-include $dir/config.h',
	'-D _GNU_SOURCE',
	'-D _LARGEFILE64_SOURCE',
	'-I $srcdir/include',
	'-I $srcdir/module/icp/include',
	'-I $srcdir/lib/libspl/include',
	'-I $srcdir/lib/libspl/include/os/linux',
	'-I $srcdir/lib/libzutil',
	'-I $srcdir/lib/libshare',
	'-I $srcdir/cmd/zpool',
	'-isystem $builddir/pkg/bearssl/include',
	'-isystem $builddir/pkg/libtirpc/include',
	'-isystem $builddir/pkg/linux-headers/include',
	'-isystem $builddir/pkg/util-linux/include',
	'-isystem $builddir/pkg/zlib/include',
}

pkg.deps = {
	'pkg/bearssl/headers',
	'pkg/libtirpc/headers',
	'pkg/linux-headers/headers',
	'pkg/util-linux/headers',
	'pkg/zlib/headers',
}

lib('libavl.a', {'module/avl/avl.c'})

lib('libshare.a', [[
	lib/libshare/(
		libshare.c
		os/linux/(nfs.c smb.c)
	)
]])

lib('libspl.a', [[
	lib/libspl/(
		assert.c
		atomic.c
		list.c
		mkdirp.c
		page.c
		strlcat.c
		strlcpy.c
		timestamp.c
		os/linux/(
			getexecname.c
			gethostid.c
			getmntany.c
			zone.c
		)
	)
]])

lib('libtpool.a', {'lib/libtpool/thread_pool.c'})

lib('libefi.a', [[
	lib/libefi/rdwr_efi.c
	$builddir/pkg/util-linux/libuuid.a.d
]])

lib('libnvpair.a', [[
	lib/libnvpair/(
		libnvpair.c
		libnvpair_json.c
		nvpair_alloc_system.c
	)
	module/nvpair/(
		nvpair_alloc_fixed.c
		nvpair.c
		fnvpair.c
	)
	$builddir/pkg/libtirpc/libtirpc.a
]])

lib('libzutil.a', [[
	lib/libzutil/(
		zutil_device_path.c
		zutil_import.c
		zutil_nicenum.c
		zutil_pool.c
		os/linux/(
			zutil_device_path_os.c
			zutil_import_os.c
			zutil_compat.c
		)
	)
	libefi.a.d
	libspl.a
	libtpool.a
	$builddir/pkg/util-linux/libblkid.a.d
]])

lib('libuutil.a', [[
	lib/libuutil/(
		uu_alloc.c
		uu_avl.c
		uu_dprintf.c
		uu_ident.c
		uu_list.c
		uu_misc.c
		uu_open.c
		uu_pname.c
		uu_string.c
	)
	libavl.a
	libspl.a
]])

lib('libzfs_core.a', [[
	lib/libzfs_core/(
		libzfs_core.c
	)
	libzutil.a.d
]])

lib('libzfs.a', [[
	lib/libzfs/(
		libzfs_changelist.c
		libzfs_config.c
		libzfs_crypto.c
		libzfs_dataset.c
		libzfs_diff.c
		libzfs_import.c
		libzfs_iter.c
		libzfs_mount.c
		libzfs_pool.c
		libzfs_sendrecv.c
		libzfs_status.c
		libzfs_util.c
		os/linux/(
			libzfs_mount_os.c
			libzfs_pool_os.c
			libzfs_sendrecv_os.c
			libzfs_util_os.c
		)
	)
	module/(
		zcommon/(
			cityhash.c
			zfeature_common.c
			zfs_comutil.c
			zfs_fletcher.c
			zfs_fletcher_superscalar.c
			zfs_fletcher_superscalar4.c
			zfs_namecheck.c
			zfs_prop.c
			zpool_prop.c
			zprop_common.c
		)
	)
	libnvpair.a.d
	libuutil.a.d
	libshare.a.d
	libzfs_core.a.d
	$builddir/pkg/bearssl/libbearssl.a
	$builddir/pkg/zlib/libz.a
]])

exe('zed', [[
	cmd/zed/(
		zed.c
		zed_conf.c
		zed_disk_event.c
		zed_event.c
		zed_exec.c
		zed_file.c
		zed_log.c
		zed_strings.c
		agents/(
			zfs_agents.c
			zfs_diagnosis.c
			zfs_mod.c
			zfs_retire.c
			fmd_api.c
			fmd_serd.c
		)
	)
	libzfs.a.d
]])
file('bin/zed', '755', '$outdir/zed')
build('sed', '$outdir/zed.8', '$srcdir/man/man8/zed.8.in', {
	expr={
		'-e s,@sysconfdir@,/etc,',
		'-e s,@zfsexecdir@,/libexec/zfs,',
		'-e s,@runstatedir@,/run,',
	},
})

exe('zfs', [[
	cmd/zfs/(
		zfs_iter.c
		zfs_main.c
		zfs_project.c
	)
	libzfs.a.d
	libuutil.a.d
]])
file('bin/zfs', '755', '$outdir/zfs')

exe('zpool', [[
	cmd/zpool/(
		zpool_iter.c
		zpool_main.c
		zpool_util.c
		zpool_vdev.c
		os/linux/zpool_vdev_os.c
	)
	libzfs.a.d
]])
file('bin/zpool', '755', '$outdir/zpool')

exe('zstream', [[
	cmd/zstream/(
		zstream.c
		zstream_dump.c
		zstream_redup.c
		zstream_token.c
	)
	libzfs.a.d
]])
file('bin/zstream', '755', '$outdir/zstream')
sym('bin/zstreamdump', 'zstream')

man(paths[[
	man/(
		man4/zfs.4
		man8/(
			zfs.8
			zfs-allow.8
			zfs-bookmark.8
			zfs-change-key.8
			zfs-clone.8
			zfs-create.8
			zfs-destroy.8
			zfs-diff.8
			zfs-get.8
			zfs-groupspace.8
			zfs-hold.8
			zfs-inherit.8
			zfs-jail.8
			zfs-list.8
			zfs-load-key.8
			zfs-mount.8
			zfs-program.8
			zfs-project.8
			zfs-projectspace.8
			zfs-promote.8
			zfs-receive.8
			zfs-recv.8
			zfs-redact.8
			zfs-release.8
			zfs-rename.8
			zfs-rollback.8
			zfs-send.8
			zfs-set.8
			zfs-share.8
			zfs-snapshot.8
			zfs-unallow.8
			zfs-unjail.8
			zfs-unload-key.8
			zfs-unmount.8
			zfs-upgrade.8
			zfs-userspace.8
			zfs-wait.8
			zpool.8
			zpool-add.8
			zpool-attach.8
			zpool-checkpoint.8
			zpool-clear.8
			zpool-create.8
			zpool-destroy.8
			zpool-detach.8
			zpool-events.8
			zpool-export.8
			zpool-get.8
			zpool-history.8
			zpool-import.8
			zpool-initialize.8
			zpool-iostat.8
			zpool-labelclear.8
			zpool-list.8
			zpool-offline.8
			zpool-online.8
			zpool-reguid.8
			zpool-remove.8
			zpool-reopen.8
			zpool-replace.8
			zpool-resilver.8
			zpool-scrub.8
			zpool-set.8
			zpool-split.8
			zpool-status.8
			zpool-sync.8
			zpool-trim.8
			zpool-upgrade.8
			zpool-wait.8
			zstream.8
			zstreamdump.8
		)
		man7/(
			zfsconcepts.7
			zfsprops.7
			zpool-features.7
			zpoolconcepts.7
			zpoolprops.7
		)
	)
	$outdir/zed.8
]])

fetch 'curl'
