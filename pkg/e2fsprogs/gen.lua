set('version', '1.46.4')
cflags{
	'-std=c99', '-Wall',
        '-Wno-address-of-packed-member', '-Wno-format-truncation',
        '-Wno-unused-variable', '-Wno-stringop-truncation',
        '-Wno-stringop-overflow', '-Wno-unused-label',
	'-D HAVE_CONFIG_H',
	'-I $outdir',
	'-I $outdir/include',
	'-I $outdir/internal',
	'-I $outdir/internal/support',
	'-I $srcdir/lib',
	'-isystem $builddir/pkg/linux-headers/include',
	'-isystem $builddir/pkg/util-linux/include',
}

build('cat', '$outdir/config.h', {
	'$builddir/probe/HAVE__THREAD_LOCAL',
	'$builddir/probe/SIZEOF_LONG',
	'$builddir/probe/SIZEOF_TIME_T',
	'$dir/config.h',
})

set('subst', {
	'-e s,@E2FSPROGS_VERSION@,$version,',
	'-e s,@E2FSPROGS_MONTH@,Aug,',
	'-e s,@E2FSPROGS_YEAR@,2021,',
	'-e s,@JDEV@,,',
})

local function et(file, src, hdr)
	src = '$outdir/'..src
	hdr = '$outdir/'..hdr
	build('awk', src, {file, '|', '$srcdir/lib/et/et_c.awk'}, {
		expr='-f $srcdir/lib/et/et_c.awk -v outfile=/dev/stdout outfn='..src:match('[^/]*$'),
	})
	build('awk', hdr, {file, '|', '$srcdir/lib/et/et_h.awk'}, {
		expr='-f $srcdir/lib/et/et_h.awk -v outfile=/dev/stdout outfn='..hdr:match('[^/]*$'),
	})
end

local function subst(output, input)
	output = '$outdir/'..output
	build('sed', output, '$srcdir/'..input, {expr='$subst'})
	return output
end

local function substman(files)
	for _, file in ipairs(files) do
		if file:hassuffix('.in') then
			file = subst(file:sub(1, -4), file)
		end
		man{file}
	end
end

subst('ext2_err.et', 'lib/ext2fs/ext2_err.et.in')
et('$outdir/ext2_err.et', 'ext2_err.c', 'include/ext2fs/ext2_err.h')
et('$srcdir/lib/support/prof_err.et', 'prof_err.c', 'internal/support/prof_err.h')

build('copy', '$outdir/include/blkid/blkid.h', '$srcdir/lib/blkid/blkid.h.in')
build('copy', '$outdir/include/ext2fs/ext2_types.h', '$dir/ext2_types.h')
build('copy', '$outdir/internal/blkid/blkid_types.h', '$dir/blkid_types.h')

sub('tools.ninja', function()
	toolchain(config.host)
	exe('gen_crc32ctable', {'lib/ext2fs/gen_crc32ctable.c'})
end)
rule('gen_crc32ctable', '$outdir/gen_crc32ctable >$out')
build('gen_crc32ctable', '$outdir/internal/crc32c_table.h', {'|', '$outdir/gen_crc32ctable'})

pkg.hdrs = {
	'$outdir/include/blkid/blkid.h',
	'$outdir/include/ext2fs/ext2_err.h',
	'$outdir/include/ext2fs/ext2_types.h',
}
pkg.deps = {
	'$outdir/config.h',
	'$gendir/headers',
	'$outdir/internal/blkid/blkid_types.h',
	'$outdir/internal/support/prof_err.h',
	'$outdir/internal/crc32c_table.h',
	'pkg/linux-headers/headers',
	'pkg/util-linux/headers',
}

lib('libcomm_err.a', [[lib/et/(error_message.c et_name.c init_et.c com_err.c com_right.c)]])
lib('libblkid.a', [[lib/blkid/(
	cache.c dev.c devname.c devno.c getsize.c llseek.c probe.c
	read.c resolve.c save.c tag.c version.c
)]])
lib('libe2p.a', [[lib/e2p/(
	feature.c fgetflags.c fsetflags.c fgetversion.c fsetversion.c
	getflags.c getversion.c hashstr.c iod.c ls.c ljs.c mntopts.c
	parse_num.c pe.c pf.c ps.c setflags.c setversion.c uuid.c
	ostype.c percent.c crypto_mode.c fgetproject.c fsetproject.c
	encoding.c errcode.c
)]])
lib('libext2fs.a', [[$outdir/ext2_err.c lib/ext2fs/(
	alloc.c
	alloc_sb.c
	alloc_stats.c
	alloc_tables.c
	atexit.c
	badblocks.c
	bb_inode.c
	bitmaps.c
	bitops.c
	blkmap64_ba.c
	blkmap64_rb.c
	blknum.c
	block.c
	bmap.c
	check_desc.c
	closefs.c
	crc16.c
	crc32c.c
	csum.c
	dblist.c
	dblist_dir.c
	dirblock.c
	dirhash.c
	dir_iterate.c
	expanddir.c
	ext_attr.c
	extent.c
	fallocate.c
	fileio.c
	finddev.c
	flushb.c
	freefs.c
	gen_bitmap.c
	gen_bitmap64.c
	get_num_dirs.c
	get_pathname.c
	getsize.c
	getsectsize.c
	hashmap.c
	i_block.c
	icount.c
	ind_block.c
	initialize.c
	inline.c
	inline_data.c
	inode.c
	io_manager.c
	ismounted.c
	link.c
	llseek.c
	lookup.c
	mkdir.c
	mkjournal.c
	mmp.c
	namei.c
	native.c
	newdir.c
	nls_utf8.c
	openfs.c
	progress.c
	punch.c
	qcow2.c
	read_bb.c
	read_bb_file.c
	res_gdt.c
	rw_bitmaps.c
	sha512.c
	swapfs.c
	symlink.c
	undo_io.c
	unix_io.c
	sparse_io.c
	unlink.c
	valid_blk.c
	version.c
	rbtree.c

	dupfs.c
)]])
lib('libsupport.a', [[$outdir/prof_err.c lib/support/(
	cstring.c
	mkquota.c
	plausible.c
	profile.c
	parse_qtype.c
	profile_helpers.c
	quotaio.c
	quotaio_v2.c
	quotaio_tree.c
	dict.c
)]])

exe('bin/e2fsck', [[
	e2fsck/(
		unix.c e2fsck.c super.c pass1.c pass1b.c pass2.c
		pass3.c pass4.c pass5.c journal.c badblocks.c util.c dirinfo.c
		dx_dirinfo.c ehandler.c problem.c message.c quota.c recovery.c
		region.c revoke.c ea_refcount.c rehash.c
		logfile.c sigcatcher.c readahead.c
		extents.c encrypted_files.c
	)
	libsupport.a libext2fs.a libe2p.a libblkid.a libcomm_err.a
	$builddir/pkg/util-linux/libuuid.a.d
]])
file('bin/e2fsck', '755', '$outdir/bin/e2fsck')
substman{'e2fsck/e2fsck.8.in', 'e2fsck/e2fsck.conf.5.in'}

exe('bin/resize2fs', [[
	resize/(
		extent.c resize2fs.c main.c online.c resource_track.c
		sim_progress.c
	)
	libext2fs.a libe2p.a libcomm_err.a
]])
file('bin/resize2fs', '755', '$outdir/bin/resize2fs')
substman{'resize/resize2fs.8.in'}

build('awk', '$outdir/default_profile.c', {'$srcdir/misc/mke2fs.conf.in', '|', '$srcdir/misc/profile-to-c.awk'}, {
	expr='-f $srcdir/misc/profile-to-c.awk',
})

exe('bin/mke2fs', [[
	misc/(
		mke2fs.c util.c mk_hugefiles.c
		create_inode.c
	)
	$outdir/default_profile.c
	libsupport.a libext2fs.a libe2p.a libblkid.a libcomm_err.a
	$builddir/pkg/util-linux/libuuid.a.d
]])
file('bin/mke2fs', '755', '$outdir/bin/mke2fs')
substman{'misc/mke2fs.8.in'}

fetch 'git'
