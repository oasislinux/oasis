cflags{
	'-I $srcdir/lasagna',
	'-I $outdir',
}

sub('tools.ninja', function()
	toolchain 'host'
	exe('mk_outvec', {'lasagna/outvec/mk_outvec.c'})
	exe('mk_rlimit', {'lasagna/rlimit/mk_rlimit.c'})
	exe('mksysstr', {'lasagna/sysstr/mksysstr.c'})
end)

rule('outvec', '$outdir/mk_outvec >$out')
build('outvec', '$outdir/outvec_STDOUT.h', {'|', '$outdir/mk_outvec'})

rule('rlimit', '$outdir/mk_rlimit >$out')
build('rlimit', '$outdir/rlimit_defs.c.in', {'|', '$outdir/mk_rlimit'})

rule('sysstr', '$outdir/mksysstr $type >$out')
build('sysstr', '$outdir/sysstr_errno.c.in', {'|', '$outdir/mksysstr'}, {type='errno'})
build('sysstr', '$outdir/sysstr_signo.c.in', {'|', '$outdir/mksysstr'}, {type='signo'})

pkg.deps = {
	'$outdir/outvec_STDOUT.h',
	'$outdir/rlimit_defs.c.in',
	'$outdir/sysstr_errno.c.in',
	'$outdir/sysstr_signo.c.in',
}

lib('libasagna.a', [[lasagna/(
	buf/buf_(cmp copy fill ndx rcopy rndx).c
	cstr/cstr_(cat chop cmp cmpi contains copy dup lcat lcpy len ltrim match matchi ncmp pos rpos rtrim trim vcat_ vcopy_ vlen_).c
	cdb/(cdb_(find cc clear close distance dynget dynread get hashpart init open read seq) cdbmk_(add addioq addrec clear finish init _update)).c
	devout/devout.c
	domsock/domsock_(accept close connect create).c
	dynbuf/(dynbuf.c dynbuf_(clear copy free freebuf grow need new pack put putb).c)
	dynstr/(dynstr.c dynstr_(chop clear copy copys free freestr grow need new put putc putn puts set vputs_).c)
	dynstuf/dynstuf_(find free get grow init isempty items new peek pop push replace reverse set slots sort stuf visit).c
	execvx/execvx.c
	fd/fd_(blocking cloexec dupe move nonblock).c
	hdb/hdb_(find cc clear close distance dynget dynread get hashpart init open read seq).c
	hdb/hdbmk_(add addioq addrec clear finish start _update).c
	hfunc/hfunc_(djba djbm djbx elf1 fnva fnvm ghfa ghfm ghfx jsw1 kp37 kr31 kx17 murm oat1 p50a pjw1 rsuh rot1 rotm sax1 sdbm sfh1 postmix32).c
	ioq/ioq_(get getln init put putfd putfile stderr stdin stdout vputs_).c
	newenv/newenv.c
	nextopt/(nextopt nextopt_progname).c
	nfmt/nfmt_(uint32 uint32_pad uint32_pad_ uint32_pad0 uint32_pad0_ uint32o uint32o_pad0 uint32o_pad0_ uint32x uint32x_pad uint32x_pad_ uint32x_pad0 uint32x_pad0_ uint64 uint64_pad uint64_pad_ uint64_pad0 uint64_pad0_).c
	nuscan/nuscan_(uint32 uint32o).c
	outvec/outvec_(STDERR STDOUT flush put puts vputs_).c
	packet/packet_(read write).c
	padlock/padlock_(exbyte exlock extest fcntl shbyte shlock shtest unbyte unlock).c
	pidlock/pidlock_(check set).c
	pkt/pkt_(load read write).c
	pollio/pollio.c
	rlimit/rlimit.c
	sig/sig_(block catch catchr unblock).c
	sysstr/sysstr_(errno signal).c
	tain/tain_(assign iszero less load load_msecs load_utc minus now pack packhex pause plus tai_pack tai_unpack uptime to_float to_msecs to_utc unpack unpackhex).c
	tx64/(base64_vec tx64_encode).c
	ufunc/ufunc_(u32add u48add).c
	upak/upak_vpack.c
	upak/(upak upak(16 24 32 48 64))_pack.c
	upak/(upak upak(16 24 32 48 64))_unpack.c
)]])

exe('perpd', 'perp/(perpd.c perpd_conn.c perpd_svdef.c) libasagna.a')
file('bin/perpd', '755', '$outdir/perpd')
man{'perp/man/perpd.8'}

for _, cmd in ipairs{'perpboot', 'perpctl', 'perphup', 'perpls', 'perpok', 'perpstat'} do
	file('bin/'..cmd, '755', exe(cmd, {'perp/'..cmd..'.c', 'libasagna.a'}))
	man{'perp/man/'..cmd..'.8'}
end

cc('perp/tinylog.c', nil, {
	cflags='$cflags -D \'TINYLOG_ZIP="/bin/gzip"\' -D \'ZIP_EXT=".gz"\'',
})
link('tinylog', {'perp/tinylog.c.o', 'libasagna.a'})
file('bin/tinylog', '755', '$outdir/tinylog')
man{'perp/man/tinylog.8'}

local tools = {
	'runargs', 'runargv0', 'runchoom', 'rundetach', 'rundeux', 'runenv',
	'runfile', 'runlimit', 'runlock', 'runpause', 'runsession', 'runtool',
	'runtrap', 'runuid',

	'catargs', 'catenv', 'catlimits', 'catuid',
}
for _, tool in ipairs(tools) do
	file('bin/'..tool, '755', exe(tool, {'runtools/'..tool..'.c', 'libasagna.a'}))
	if not tool:hasprefix('cat') then
		man{'runtools/man/'..tool..'.8'}
	end
end

man{
	'perp/man/perpetrate.5',
	'perp/man/perp_intro.8',
	'runtools/man/runtools_intro.8',
}

fetch 'curl'
