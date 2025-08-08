cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $srcdir/libarchive',
	'-I $srcdir/libarchive_fe',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/libarchive', {
	'archive.h',
	'archive_entry.h',
})

lib('libarchive.a', [[libarchive/(
	archive_acl.c
	archive_blake2sp_ref.c
	archive_blake2s_ref.c
	archive_check_magic.c
	archive_cmdline.c
	archive_cryptor.c
	archive_digest.c
	archive_disk_acl_darwin.c
	archive_disk_acl_freebsd.c
	archive_disk_acl_linux.c
	archive_disk_acl_sunos.c
	archive_entry.c
	archive_entry_copy_bhfi.c
	archive_entry_copy_stat.c
	archive_entry_link_resolver.c
	archive_entry_sparse.c
	archive_entry_stat.c
	archive_entry_strmode.c
	archive_entry_xattr.c
	archive_getdate.c
	archive_hmac.c
	archive_match.c
	archive_options.c
	archive_pack_dev.c
	archive_pathmatch.c
	archive_ppmd7.c
	archive_ppmd8.c
	archive_random.c
	archive_rb.c
	archive_read_add_passphrase.c
	archive_read_append_filter.c
	archive_read.c
	archive_read_data_into_fd.c
	archive_read_disk_entry_from_file.c
	archive_read_disk_posix.c
	archive_read_disk_set_standard_lookup.c
	archive_read_disk_windows.c
	archive_read_extract2.c
	archive_read_extract.c
	archive_read_open_fd.c
	archive_read_open_file.c
	archive_read_open_filename.c
	archive_read_open_memory.c
	archive_read_set_format.c
	archive_read_set_options.c
	archive_read_support_filter_all.c
	archive_read_support_filter_by_code.c
	archive_read_support_filter_bzip2.c
	archive_read_support_filter_compress.c
	archive_read_support_filter_grzip.c
	archive_read_support_filter_gzip.c
	archive_read_support_filter_lrzip.c
	archive_read_support_filter_lz4.c
	archive_read_support_filter_lzop.c
	archive_read_support_filter_none.c
	archive_read_support_filter_program.c
	archive_read_support_filter_rpm.c
	archive_read_support_filter_uu.c
	archive_read_support_filter_xz.c
	archive_read_support_filter_zstd.c
	archive_read_support_format_7zip.c
	archive_read_support_format_all.c
	archive_read_support_format_ar.c
	archive_read_support_format_by_code.c
	archive_read_support_format_cab.c
	archive_read_support_format_cpio.c
	archive_read_support_format_empty.c
	archive_read_support_format_iso9660.c
	archive_read_support_format_lha.c
	archive_read_support_format_mtree.c
	archive_read_support_format_rar5.c
	archive_read_support_format_rar.c
	archive_read_support_format_raw.c
	archive_read_support_format_tar.c
	archive_read_support_format_warc.c
	archive_read_support_format_xar.c
	archive_read_support_format_zip.c
	archive_string.c
	archive_string_sprintf.c
	archive_util.c
	archive_version_details.c
	archive_virtual.c
	archive_windows.c
	archive_write_add_filter_b64encode.c
	archive_write_add_filter_by_name.c
	archive_write_add_filter_bzip2.c
	archive_write_add_filter.c
	archive_write_add_filter_compress.c
	archive_write_add_filter_grzip.c
	archive_write_add_filter_gzip.c
	archive_write_add_filter_lrzip.c
	archive_write_add_filter_lz4.c
	archive_write_add_filter_lzop.c
	archive_write_add_filter_none.c
	archive_write_add_filter_program.c
	archive_write_add_filter_uuencode.c
	archive_write_add_filter_xz.c
	archive_write_add_filter_zstd.c
	archive_write.c
	archive_write_disk_posix.c
	archive_write_disk_set_standard_lookup.c
	archive_write_disk_windows.c
	archive_write_open_fd.c
	archive_write_open_file.c
	archive_write_open_filename.c
	archive_write_open_memory.c
	archive_write_set_format_7zip.c
	archive_write_set_format_ar.c
	archive_write_set_format_by_name.c
	archive_write_set_format.c
	archive_write_set_format_cpio_binary.c
	archive_write_set_format_cpio.c
	archive_write_set_format_cpio_newc.c
	archive_write_set_format_cpio_odc.c
	archive_write_set_format_filter_by_ext.c
	archive_write_set_format_gnutar.c
	archive_write_set_format_iso9660.c
	archive_write_set_format_mtree.c
	archive_write_set_format_pax.c
	archive_write_set_format_raw.c
	archive_write_set_format_shar.c
	archive_write_set_format_ustar.c
	archive_write_set_format_v7tar.c
	archive_write_set_format_warc.c
	archive_write_set_format_xar.c
	archive_write_set_format_zip.c
	archive_write_set_options.c
	archive_write_set_passphrase.c
	filter_fork_posix.c
	filter_fork_windows.c
	xxhash.c
)]])
file('lib/libarchive.a', '644', '$outdir/libarchive.a')


lib('libarchive_fe.a', [[libarchive_fe/(
	passphrase.c
	line_reader.c
	err.c
)]])

exe('bin/bsdtar', [[
	tar/(
		bsdtar.c
		bsdtar_windows.c
		cmdline.c
		creation_set.c
		read.c
		subst.c
		util.c
		write.c
	)
	libarchive.a libarchive_fe.a 
]])
file('bin/bsdtar', '755', '$outdir/bin/bsdtar')

fetch 'curl'
