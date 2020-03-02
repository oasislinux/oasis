cflags{
	'-std=c99', '-Wall', '-Wpedantic', '-Wno-maybe-uninitialized',
	'-D _DEFAULT_SOURCE',
	'-D _BSD_SOURCE',
	'-D _XOPEN_SOURCE=700',
	'-I $outdir',
}

lib('libutil.a', [[libutil/(
	concat.c
	cp.c
	crypt.c
	ealloc.c
	enmasse.c
	eprintf.c
	eregcomp.c
	estrtod.c
	fnck.c
	fshut.c
	getlines.c
	human.c
	linecmp.c
	md5.c
	memmem.c
	mkdirp.c
	mode.c
	parseoffset.c
	putword.c
	reallocarray.c
	recurse.c
	rm.c
	sha1.c
	sha224.c
	sha256.c
	sha384.c
	sha512.c
	sha512-224.c
	sha512-256.c
	strcasestr.c
	strlcat.c
	strlcpy.c
	strsep.c
	strtonum.c
	unescape.c
	writeall.c
)]])
lib('libutf.a', [[libutf/(
	fgetrune.c
	fputrune.c
	isalnumrune.c
	isalpharune.c
	isblankrune.c
	iscntrlrune.c
	isdigitrune.c
	isgraphrune.c
	isprintrune.c
	ispunctrune.c
	isspacerune.c
	istitlerune.c
	isxdigitrune.c
	lowerrune.c
	rune.c
	runetype.c
	upperrune.c
	utf.c
	utftorunestr.c
)]])

rule('getconf', '$srcdir/getconf.sh >$out')
build('getconf', '$outdir/getconf.h', {'|', '$srcdir/getconf.sh'})

local cmds = {
	'basename',
	'cal',
	'cat',
	'chgrp',
	'chmod',
	'chown',
	'chroot',
	'cksum',
	'cmp',
	'cols',
	'comm',
	'cp',
	'cron',
	'cut',
	'date',
	'dirname',
	'du',
	'echo',
	'ed',
	'env',
	'expand',
	'expr',
	'false',
	'find',
	'flock',
	'fold',
	'getconf',
	'grep',
	'head',
	'hostname',
	'install',
	'join',
	'kill',
	'link',
	'ln',
	'logger',
	'logname',
	'ls',
	'md5sum',
	'mkdir',
	'mkfifo',
	'mknod',
	'mktemp',
	'mv',
	'nice',
	'nl',
	'nohup',
	'od',
	'paste',
	'pathchk',
	'printenv',
	'printf',
	'pwd',
	'readlink',
	'renice',
	'rev',
	'rm',
	'rmdir',
	'sed',
	'seq',
	'setsid',
	'sha1sum',
	'sha224sum',
	'sha256sum',
	'sha384sum',
	'sha512-224sum',
	'sha512-256sum',
	'sha512sum',
	'sleep',
	'sort',
	'split',
	'sponge',
	-- use strings from binutils
	'sync',
	'tail',
	-- use tar from OpenBSD
	'tee',
	'test',
	'tftp',
	'time',
	'touch',
	'tr',
	'true',
	'tsort',
	'tty',
	'uname',
	'unexpand',
	'uniq',
	'unlink',
	'uudecode',
	'uuencode',
	'wc',
	'which',
	'whoami',
	'xargs',
	'yes',
}
for _, cmd in ipairs(cmds) do
	local src = cmd
	if src == 'install' then
		src = 'xinstall'
	end
	local deps
	if cmd == 'getconf' then
		deps = {'$outdir/getconf.h'}
	end
	file('bin/'..cmd, '755', exe(cmd, {src..'.c', 'libutil.a', 'libutf.a'}, deps))
	local out = '$outdir/'..cmd..'.1.gz'
	build('gzip', out, '$srcdir/'..src..'.1')
	file('share/man/man1/'..cmd..'.1.gz', '644', out)
end

sym('bin/[', 'test')

-- TODO: binutils'  config/lib-ld.m4 should use AC_REQUIRE([AC_PROG_EGREP]) and
-- $EGREP instead of egrep.
file('bin/egrep', '755', '$dir/egrep')

fetch 'git'
