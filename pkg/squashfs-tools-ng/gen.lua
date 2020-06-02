cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-D _XOPEN_SOURCE=700',
	'-I $srcdir',
	'-I $srcdir/include',
	'-I $dir',
}

pkg.deps = {}

local cfg = {}
for line in iterlines('config.h', 1) do
	local var = line:match('^#define (WITH_[%w_]+)')
	if var then
		cfg[var] = true
	end
end

local srcs = paths[[
	lib/sqfs/(
		id_table.c super.c
		readdir.c xattr.c
		write_table.c meta_writer.c
		read_super.c meta_reader.c
		read_inode.c write_inode.c
		dir_writer.c xattr_reader.c
		read_table.c comp/compressor.c
		xattr_writer.c
		dir_reader.c read_tree.c
		inode.c
		write_super.c data_reader.c
		block_processor/common.c
		frag_table.c
		block_writer.c

		unix/io_file.c
		block_processor/winpthread.c
	)
	libutil.a
]]

if cfg.WITH_GZIP then
	cflags{'-I $builddir/pkg/zlib/include'}
	table.insert(pkg.deps, 'pkg/zlib/headers')
	table.insert(srcs, {
		'lib/sqfs/comp/gzip.c',
		'$builddir/pkg/zlib/libz.a',
	})
end

if cfg.WITH_ZSTD then
	cflags{'-I $builddir/pkg/zstd/include'}
	table.insert(srcs, {
		'lib/sqfs/comp/zstd.c',
		'$builddir/pkg/zstd/libzstd.a',
	})
end

lib('libsquashfs.a', srcs)

lib('libcommon.a', [[
	lib/common/(
		serialize_fstree.c statistics.c
		inode_stat.c hardlink.c
		print_version.c data_reader_dump.c
		compress.c comp_opt.c
		data_writer.c
		get_path.c io_stdin.c
		writer.c perror.c
		mkdir_p.c parse_size.c
		print_size.c
	)
	libsquashfs.a.d
	libfstree.a
]])

lib('libfstree.a', [[
	lib/fstree/(
		fstree.c fstree_from_file.c
		fstree_sort.c hardlink.c
		post_process.c get_path.c
		mknode.c
		add_by_path.c get_by_path.c
		source_date_epoch.c
		canonicalize_name.c
		filename_sane.c
	)
]])

lib('libtar.a', [[
	lib/tar/(
		read_header.c write_header.c skip.c
		number.c checksum.c cleanup.c
		read_sparse_map.c read_sparse_map_old.c
		base64.c urldecode.c
		padd_file.c read_retry.c
		write_retry.c pax_header.c
	)
]])

lib('libutil.a', [[
	lib/util/(
		str_table.c alloc.c
		rbtree.c
		xxhash.c hash_table.c
	)
]])

exe('gensquashfs', [[
	bin/gensquashfs/(mkfs.c options.c selinux.c dirscan.c dirscan_xattr.c)
	libcommon.a.d
]])
file('bin/gensquashfs', '755', '$outdir/gensquashfs')
man{'doc/gensquashfs.1'}

exe('rdsquashfs', [[
	bin/rdsquashfs/(
		rdsquashfs.c
		list_files.c options.c
		restore_fstree.c describe.c
		fill_files.c dump_xattrs.c
	)
	libcommon.a.d
]])
file('bin/rdsquashfs', '755', '$outdir/rdsquashfs')
man{'doc/rdsquashfs.1'}

exe('sqfsdiff', [[
	bin/sqfsdiff/(
		sqfsdiff.c
		util.c options.c
		compare_dir.c node_compare.c
		compare_files.c super.c
		extract.c
	)
	libcommon.a.d
]])
file('bin/sqfsdiff', '755', '$outdir/sqfsdiff')
man{'doc/sqfsdiff.1'}

exe('sqfs2tar', 'bin/sqfs2tar.c libcommon.a.d libtar.a')
file('bin/sqfs2tar', '755', '$outdir/sqfs2tar')
man{'doc/sqfs2tar.1'}

exe('tar2sqfs', 'bin/tar2sqfs.c libcommon.a.d libtar.a')
file('bin/tar2sqfs', '755', '$outdir/tar2sqfs')
man{'doc/tar2sqfs.1'}

fetch 'git'
