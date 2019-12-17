cflags{
	'-include $dir/config.h',
	'-I $srcdir',
	'-I $srcdir/compat/regex',
	'-I $outdir',
	'-I $builddir/pkg/curl/include',
	'-I $builddir/pkg/zlib/include',
}

rule('cmdlist', 'cd $srcdir && ./generate-cmdlist.sh $$OLDPWD/$in >$$OLDPWD/$out')
build('cmdlist', '$outdir/command-list.h', {
	'$srcdir/command-list.txt', '|', expand{'$srcdir/Documentation/', lines('commands.txt')},
})

pkg.deps = {'$outdir/command-list.h', 'pkg/curl/headers', 'pkg/zlib/headers'}

cc('exec-cmd.c', nil, {cflags=[[$cflags '-DFALLBACK_RUNTIME_PREFIX=""']]})
cc('common-main.c')
cc('http.c')
cc('compat/regex/regex.c', nil, {cflags='$cflags -DGAWK -DNO_MBSUPPORT'})

-- src/Makefile:/^LIB_OBJS.\+=
lib('libgit.a', [[
	abspath.c
	advice.c
	alias.c
	alloc.c
	apply.c
	archive-tar.c
	archive-zip.c
	archive.c
	argv-array.c
	attr.c
	base85.c
	bisect.c
	blame.c
	blob.c
	branch.c
	bulk-checkin.c
	bundle.c
	cache-tree.c
	chdir-notify.c
	checkout.c
	color.c
	column.c
	combine-diff.c
	commit.c
	commit-graph.c
	commit-reach.c
	compat/obstack.c
	compat/regex/regex.c.o
	compat/terminal.c
	compat/qsort_s.c
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
	diff-delta.c
	diff-lib.c
	diff-no-index.c
	diff.c
	diffcore-break.c
	diffcore-delta.c
	diffcore-order.c
	diffcore-pickaxe.c
	diffcore-rename.c
	dir.c
	dir-iterator.c
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
	fsck.c
	fsmonitor.c
	gettext.c
	gpg-interface.c
	graph.c
	grep.c
	hashmap.c
	linear-assignment.c
	help.c
	hex.c
	ident.c
	interdiff.c
	json-writer.c
	kwset.c
	levenshtein.c
	line-log.c
	line-range.c
	list-objects.c
	list-objects-filter.c
	list-objects-filter-options.c
	ll-merge.c
	lockfile.c
	log-tree.c
	ls-refs.c
	mailinfo.c
	mailmap.c
	match-trees.c
	mem-pool.c
	merge-blobs.c
	merge-recursive.c
	merge.c
	mergesort.c
	midx.c
	name-hash.c
	negotiator/default.c
	negotiator/skipping.c
	notes-cache.c
	notes-merge.c
	notes-utils.c
	notes.c
	object.c
	oidmap.c
	oidset.c
	packfile.c
	pack-bitmap-write.c
	pack-bitmap.c
	pack-check.c
	pack-objects.c
	pack-revindex.c
	pack-write.c
	pager.c
	parse-options-cb.c
	parse-options.c
	patch-delta.c
	patch-ids.c
	path.c
	pathspec.c
	pkt-line.c
	preload-index.c
	pretty.c
	prio-queue.c
	progress.c
	promisor-remote.c
	prompt.c
	protocol.c
	quote.c
	range-diff.c
	reachable.c
	read-cache.c
	rebase-interactive.c
	ref-filter.c
	reflog-walk.c
	refs.c
	refs/files-backend.c
	refs/iterator.c
	refs/packed-backend.c
	refs/ref-cache.c
	refspec.c
	remote.c
	replace-object.c
	repo-settings.c
	repository.c
	rerere.c
	resolve-undo.c
	revision.c
	run-command.c
	send-pack.c
	sequencer.c
	serve.c
	server-info.c
	setup.c
	sha1-array.c
	sha1-lookup.c
	sha1-file.c
	sha1-name.c
	shallow.c
	sideband.c
	sigchain.c
	split-index.c
	stable-qsort.c
	strbuf.c
	streaming.c
	string-list.c
	submodule-config.c
	submodule.c
	sub-process.c
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
		tr2_dst.c
		tr2_sid.c
		tr2_sysenv.c
		tr2_tbuf.c
		tr2_tgt_event.c
		tr2_tgt_normal.c
		tr2_tgt_perf.c
		tr2_tls.c
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
	zlib.c

	sha1dc_git.c
	sha1dc/sha1.c
	sha1dc/ubc_check.c

	sha256/block/sha256.c

	libxdiff.a
	$builddir/pkg/zlib/libz.a
]])

-- src/Makefile:/^XDIFF_OBJS.\+=
lib('libxdiff.a', [[xdiff/(
	xdiffi.c
	xprepare.c
	xutils.c
	xemit.c
	xmerge.c
	xpatience.c
	xhistogram.c
)]])

-- src/Makefile:/^BUILTIN_OBJS.\+=
local builtins = {
	'add',
	'am',
	'annotate',
	'apply',
	'archive',
	'bisect--helper',
	'blame',
	'branch',
	'bundle',
	'cat-file',
	'check-attr',
	'check-ignore',
	'check-mailmap',
	'check-ref-format',
	'checkout-index',
	'checkout',
	'clean',
	'clone',
	'column',
	'commit-tree',
	'commit',
	'commit-graph',
	'config',
	'count-objects',
	'credential',
	'describe',
	'diff-files',
	'diff-index',
	'diff-tree',
	'diff',
	'difftool',
	'env--helper',
	'fast-export',
	'fetch-pack',
	'fetch',
	'fmt-merge-msg',
	'for-each-ref',
	'fsck',
	'gc',
	'get-tar-commit-id',
	'grep',
	'hash-object',
	'help',
	'index-pack',
	'init-db',
	'interpret-trailers',
	'log',
	'ls-files',
	'ls-remote',
	'ls-tree',
	'mailinfo',
	'mailsplit',
	'merge',
	'merge-base',
	'merge-file',
	'merge-index',
	'merge-ours',
	'merge-recursive',
	'merge-tree',
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
	'remote',
	'remote-ext',
	'remote-fd',
	'repack',
	'replace',
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
local syms = {
	builtins,
	'cherry',
	'cherry-pick',
	'format-patch',
	'fsck-objects',
	'init',
	'merge-subtree',
	'restore',
	'show',
	'stage',
	'status',
	'switch',
	'whatchanged',
}
for name in iterstrings(syms) do
	sym('libexec/git-core/git-'..name, '../../bin/git')
end

local programs = {
	-- src/Makefile:/^PROGRAM_OBJS./+=
	{'credential-store'},
	{'daemon'},
	{'fast-import'},
	{'http-backend'},
	{'imap-send', {'imap-send.c', 'http.c.o', '$builddir/pkg/curl/libcurl.a.d'}},
	{'sh-i18n--envsubst'},
	{'shell'},
	-- git-remote-testsvn is intentionally omitted

	{'remote-http', {'remote-curl.c', 'http.c.o', 'http-walker.c', '$builddir/pkg/curl/libcurl.a.d'}},
}

for _, prog in ipairs(programs) do
	local name, srcs = table.unpack(prog)
	exe('git-'..name, {srcs or name..'.c', 'common-main.c.o', 'libgit.a.d'})
	file('libexec/git-core/git-'..name, '755', '$outdir/git-'..name)
end

for _, remote in ipairs{'https', 'ftp', 'ftps'} do
	sym('libexec/git-core/git-remote-'..remote, 'git-remote-http')
end

local scripts = {
	-- src/Makefile:/^SCRIPT_SH.\+=
	{'bisect', '755'},
	{'difftool--helper', '755'},
	{'filter-branch', '755'},
	{'merge-octopus', '755'},
	{'merge-one-file', '755'},
	{'merge-resolve', '755'},
	{'mergetool', '755'},
	{'quiltimport', '755'},
	{'legacy-stash', '755'},
	{'request-pull', '755'},
	{'submodule', '755'},
	{'web--browse', '755'},

	-- src/Makefile:/^SCRIPT_LIB.\+=
	{'mergetool--lib', '644'},
	{'parse-remote', '644'},
	{'rebase--preserve-merges', '644'},
	{'sh-setup', '644'},
	{'sh-i18n', '644'},
}

rule('sh_gen', 'sed -f $dir/sh_gen.sed $in >$out')
for _, script in ipairs(scripts) do
	local name, mode = table.unpack(script)
	build('sh_gen', '$outdir/git-'..name, {'$srcdir/git-'..name..'.sh', '|', '$dir/sh_gen.sed'})
	file('libexec/git-core/git-'..name, mode, '$outdir/git-'..name)
end

for _, name in ipairs{'git-shell', 'git-upload-pack'} do
	sym('bin/'..name, '../libexec/git-core/'..name)
end
for _, name in ipairs{'git-receive-pack', 'git-upload-archive'} do
	sym('bin/'..name, 'git')
end

-- templates
dir('share/git-core/templates/branches', '755')
file('share/git-core/templates/description', '644', '$srcdir/templates/this--description')
file('share/git-core/templates/info/exclude', '644', '$srcdir/templates/info--exclude')
-- Skip the sample hooks and install an empty directory instead.
dir('share/git-core/templates/hooks', '755')

man(expand{'man/', lines('man.txt')})

fetch 'local'
