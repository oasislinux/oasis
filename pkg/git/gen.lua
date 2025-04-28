cflags{
	'-include $dir/config.h',
	'-I $srcdir',
	'-I $srcdir/compat/regex',
	'-I $outdir',
	'-isystem $builddir/pkg/curl/include',
	'-isystem $builddir/pkg/zlib/include',
}

pkg.deps = {
	'$outdir/version-def.h',
	'$outdir/command-list.h',
	'$outdir/config-list.h',
	'$outdir/hook-list.h',
	'pkg/curl/headers',
	'pkg/zlib/headers',
}

rule('cmdlist', '$srcdir/generate-cmdlist.sh $srcdir $out')
build('cmdlist', '$outdir/command-list.h', {
	'|', '$srcdir/generate-cmdlist.sh', '$srcdir/command-list.txt',
	expand{'$srcdir/Documentation/', lines('commands.txt')},
})

rule('configlist', '$srcdir/generate-configlist.sh $srcdir $out')
build('configlist', '$outdir/config-list.h', {
	'|', '$srcdir/generate-configlist.sh',
	expand{'$srcdir/Documentation/', lines('configs.txt')},
})

rule('hooklist', '$srcdir/generate-hooklist.sh $srcdir $out')
build('hooklist', '$outdir/hook-list.h', {
	'|', '$srcdir/generate-hooklist.sh', '$srcdir/Documentation/githooks.adoc'
})

build('sed', '$outdir/version-def.h', '$srcdir/version-def.h.in', {
	expr={
		[[-e 's,@GIT_VERSION@,2.49.0,']],
		[[-e 's,@GIT_BUILT_FROM_COMMIT@,,']],
		[[-e 's,@GIT_USER_AGENT@,git/2.49.0,']],
	},
})

cc('exec-cmd.c', nil, {cflags=string.format([[$cflags '-DFALLBACK_RUNTIME_PREFIX="%s"']], config.prefix)})
cc('common-main.c')
cc('http.c')
cc('compat/regex/regex.c', nil, {cflags='$cflags -DGAWK -DNO_MBSUPPORT'})

-- src/Makefile:/^REFTABLE_OBJS.\+=
lib('libreftable.a', [[
	reftable/(
		basics.c
		error.c
		block.c
		blocksource.c
		iter.c
		merged.c
		pq.c
		reader.c
		record.c
		stack.c
		system.c
		tree.c
		writer.c
	)
]])

-- src/Makefile:/^LIB_OBJS.\+=
lib('libgit.a', [[
	abspath.c
	add-interactive.c
	add-patch.c
	advice.c
	alias.c
	alloc.c
	apply.c
	archive-tar.c
	archive-zip.c
	archive.c
	attr.c
	base85.c
	bisect.c
	blame.c
	blob.c
	bloom.c
	branch.c
	bulk-checkin.c
	bundle-uri.c
	bundle.c
	cache-tree.c
	cbtree.c
	chdir-notify.c
	checkout.c
	chunk-format.c
	color.c
	column.c
	combine-diff.c
	commit-graph.c
	commit-reach.c
	commit.c
	common-exit.c
	common-init.c
	compat/nonblock.c
	compat/obstack.c
	compat/qsort_s.c
	compat/regex/regex.c.o
	compat/terminal.c
	config.c
	connect.c
	connected.c
	convert.c
	copy.c
	credential.c
	csum-file.c
	ctype.c
	date.c
	decorate.c
	delta-islands.c
	diagnose.c
	diff-delta.c
	diff-merges.c
	diff-lib.c
	diff-no-index.c
	diff.c
	diffcore-break.c
	diffcore-delta.c
	diffcore-order.c
	diffcore-pickaxe.c
	diffcore-rename.c
	diffcore-rotate.c
	dir-iterator.c
	dir.c
	editor.c
	entry.c
	environment.c
	ewah/bitmap.c
	ewah/ewah_bitmap.c
	ewah/ewah_io.c
	ewah/ewah_rlw.c
	exec-cmd.c.o
	fetch-negotiator.c
	fetch-pack.c
	fmt-merge-msg.c
	fsck.c
	fsmonitor.c
	fsmonitor-ipc.c
	fsmonitor-settings.c
	gettext.c
	git-zlib.c
	gpg-interface.c
	graph.c
	grep.c
	hash-lookup.c
	hashmap.c
	help.c
	hex-ll.c
	hex.c
	hook.c
	ident.c
	json-writer.c
	kwset.c
	levenshtein.c
	line-log.c
	line-range.c
	linear-assignment.c
	list-objects-filter-options.c
	list-objects-filter.c
	list-objects.c
	lockfile.c
	log-tree.c
	loose.c
	ls-refs.c
	mailinfo.c
	mailmap.c
	match-trees.c
	mem-pool.c
	merge-blobs.c
	merge-ll.c
	merge-ort.c
	merge-ort-wrappers.c
	merge-recursive.c
	merge.c
	midx.c
	midx-write.c
	name-hash.c
	negotiator/default.c
	negotiator/noop.c
	negotiator/skipping.c
	notes-cache.c
	notes-merge.c
	notes-utils.c
	notes.c
	object-file-convert.c
	object-file.c
	object-name.c
	object.c
	oid-array.c
	oidmap.c
	oidset.c
	oidtree.c
	pack-bitmap-write.c
	pack-bitmap.c
	pack-check.c
	pack-mtimes.c
	pack-objects.c
	pack-revindex.c
	pack-write.c
	packfile.c
	pager.c
	parallel-checkout.c
	parse-options-cb.c
	parse-options.c
	parse.c
	patch-delta.c
	patch-ids.c
	path.c
	path-walk.c
	pathspec.c
	pkt-line.c
	preload-index.c
	pretty.c
	prio-queue.c
	progress.c
	promisor-remote.c
	prompt.c
	protocol.c
	protocol-caps.c
	prune-packed.c
	pseudo-merge.c
	quote.c
	range-diff.c
	reachable.c
	read-cache.c
	rebase-interactive.c
	rebase.c
	ref-filter.c
	reflog-walk.c
	reflog.c
	refs.c
	refs/debug.c
	refs/files-backend.c
	refs/reftable-backend.c
	refs/iterator.c
	refs/packed-backend.c
	refs/ref-cache.c
	refspec.c
	remote.c
	replace-object.c
	repo-settings.c
	repository.c
	rerere.c
	reset.c
	resolve-undo.c
	revision.c
	run-command.c
	send-pack.c
	sequencer.c
	serve.c
	server-info.c
	setup.c
	shallow.c
	sideband.c
	sigchain.c
	sparse-index.c
	split-index.c
	stable-qsort.c
	statinfo.c
	strbuf.c
	streaming.c
	string-list.c
	strmap.c
	strvec.c
	sub-process.c
	submodule-config.c
	submodule.c
	symlinks.c
	tag.c
	tempfile.c
	thread-utils.c
	tmp-objdir.c
	trace.c
	trace2.c
	trace2/(
		tr2_cfg.c
		tr2_cmd_name.c
		tr2_ctr.c
		tr2_dst.c
		tr2_sid.c
		tr2_sysenv.c
		tr2_tbuf.c
		tr2_tgt_event.c
		tr2_tgt_normal.c
		tr2_tgt_perf.c
		tr2_tls.c
		tr2_tmr.c
	)
	trailer.c
	transport-helper.c
	transport.c
	tree-diff.c
	tree-walk.c
	tree.c
	unpack-trees.c
	upload-pack.c
	url.c
	urlmatch.c
	usage.c
	userdiff.c
	utf8.c
	varint.c
	version.c
	versioncmp.c
	walker.c
	wildmatch.c
	worktree.c
	wrapper.c
	write-or-die.c
	ws.c
	wt-status.c
	xdiff-interface.c

	unix-socket.c
	unix-stream-server.c

	compat/simple-ipc/(ipc-shared.c ipc-unix-socket.c)

	sha1dc_git.c
	sha1dc/sha1.c
	sha1dc/ubc_check.c

	sha256/block/sha256.c

	compat/linux/procinfo.c

	libxdiff.a
	libreftable.a
	$builddir/pkg/zlib/libz.a
]])

-- src/Makefile:/^XDIFF_OBJS.\+=
lib('libxdiff.a', [[xdiff/(
	xdiffi.c
	xemit.c
	xhistogram.c
	xmerge.c
	xpatience.c
	xprepare.c
	xutils.c
)]])

-- src/Makefile:/^BUILTIN_OBJS.\+=
local builtins = {
	'add',
	'am',
	'annotate',
	'apply',
	'archive',
	'backfill',
	'bisect',
	'blame',
	'branch',
	'bugreport',
	'bundle',
	'cat-file',
	'check-attr',
	'check-ignore',
	'check-mailmap',
	'check-ref-format',
	'checkout--worker',
	'checkout-index',
	'checkout',
	'clean',
	'clone',
	'column',
	'commit-graph',
	'commit-tree',
	'commit',
	'config',
	'count-objects',
	'credential-cache--daemon',
	'credential-cache',
	'credential-store',
	'credential',
	'describe',
	'diagnose',
	'diff-files',
	'diff-index',
	'diff-tree',
	'diff',
	'difftool',
	'fast-export',
	'fast-import',
	'fetch-pack',
	'fetch',
	'fmt-merge-msg',
	'for-each-ref',
	'for-each-repo',
	'fsck',
	'fsmonitor--daemon',
	'gc',
	'get-tar-commit-id',
	'grep',
	'hash-object',
	'help',
	'hook',
	'index-pack',
	'init-db',
	'interpret-trailers',
	'log',
	'ls-files',
	'ls-remote',
	'ls-tree',
	'mailinfo',
	'mailsplit',
	'merge-base',
	'merge-file',
	'merge-index',
	'merge-ours',
	'merge-recursive',
	'merge-tree',
	'merge',
	'mktag',
	'mktree',
	'multi-pack-index',
	'mv',
	'name-rev',
	'notes',
	'pack-objects',
	'pack-redundant',
	'pack-refs',
	'patch-id',
	'prune-packed',
	'prune',
	'pull',
	'push',
	'range-diff',
	'read-tree',
	'rebase',
	'receive-pack',
	'reflog',
	'refs',
	'remote-ext',
	'remote-fd',
	'remote',
	'repack',
	'replace',
	'replay',
	'rerere',
	'reset',
	'rev-list',
	'rev-parse',
	'revert',
	'rm',
	'send-pack',
	'shortlog',
	'show-branch',
	'show-index',
	'show-ref',
	'sparse-checkout',
	'stash',
	'stripspace',
	'submodule--helper',
	'symbolic-ref',
	'tag',
	'unpack-file',
	'unpack-objects',
	'update-index',
	'update-ref',
	'update-server-info',
	'upload-archive',
	'upload-pack',
	'var',
	'verify-commit',
	'verify-pack',
	'verify-tag',
	'worktree',
	'write-tree',
}
exe('git', {'git.c', 'common-main.c.o', expand{'builtin/', builtins, '.c'}, 'libgit.a.d'})
file('bin/git', '755', '$outdir/git')

local programs = {
	-- src/Makefile:/^PROGRAM_OBJS./+=
	{'daemon'},
	{'http-backend'},
	{'imap-send', {'imap-send.c', 'http.c.o', '$builddir/pkg/curl/libcurl.a.d'}},
	{'sh-i18n--envsubst'},
	{'shell'},

	{'remote-http', {'remote-curl.c', 'http.c.o', 'http-walker.c', '$builddir/pkg/curl/libcurl.a.d'}},
}

for _, prog in ipairs(programs) do
	local name, srcs = prog[1], prog[2]
	exe('git-'..name, {srcs or name..'.c', 'common-main.c.o', 'libgit.a.d'})
	file('libexec/git-core/git-'..name, '755', '$outdir/git-'..name)
end

for _, remote in ipairs{'https', 'ftp', 'ftps'} do
	sym('libexec/git-core/git-remote-'..remote, 'git-remote-http')
end

local scripts = {
	-- src/Makefile:/^SCRIPT_SH.\+=
	{'difftool--helper', '755'},
	{'filter-branch', '755'},
	{'merge-octopus', '755'},
	{'merge-one-file', '755'},
	{'merge-resolve', '755'},
	{'mergetool', '755'},
	{'quiltimport', '755'},
	{'request-pull', '755'},
	{'submodule', '755'},
	{'web--browse', '755'},

	-- src/Makefile:/^SCRIPT_LIB.\+=
	{'mergetool--lib', '644'},
	{'sh-i18n', '644'},
	{'sh-setup', '644'},
}

rule('sh_gen', 'sed -f $dir/sh_gen.sed $in >$out')
for _, script in ipairs(scripts) do
	local name, mode = script[1], script[2]
	build('sh_gen', '$outdir/git-'..name, {'$srcdir/git-'..name..'.sh', '|', '$dir/sh_gen.sed'})
	file('libexec/git-core/git-'..name, mode, '$outdir/git-'..name)
end

sym('bin/git-shell', '../libexec/git-core/git-shell')
for _, name in ipairs{'git-receive-pack', 'git-upload-archive', 'git-upload-pack'} do
	sym('bin/'..name, 'git')
end

-- templates
file('share/git-core/templates/description', '644', '$srcdir/templates/description')
file('share/git-core/templates/info/exclude', '644', '$srcdir/templates/info/exclude')
-- Skip the sample hooks and install an empty directory instead.
dir('share/git-core/templates/hooks', '755')

man(expand{'man/', lines('man.txt')})

fetch 'local'
