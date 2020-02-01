cflags{
	'-Wall',
	'-I $dir',
	'-I $basedir/pkg/openbsd/include',
}

lib('libcommon.a', [[
	answer.c axfr.c buffer.c configlexer.c configparser.c dname.c dns.c
	edns.c iterated_hash.c lookup3.c namedb.c nsec3.c options.c packet.c
	query.c rbtree.c radtree.c rdata.c region-allocator.c rrl.c tsig.c
	tsig-openssl.c udb.c udbradtree.c udbzone.c util.c
	$builddir/pkg/openbsd/libbsd.a
]])

lib('libnsd.a', [[
        dbaccess.c dbcreate.c difffile.c ipc.c mini_event.c netio.c server.c
        zlexer.c zonec.c zparser.c
	xfrd-disk.c xfrd-notify.c xfrd-tcp.c xfrd.c remote.c
	libcommon.a.d
]])

exe('nsd', {'nsd.c', 'libnsd.a.d'})
exe('nsd-checkconf', {'nsd-checkconf.c', 'libcommon.a.d'})
exe('nsd-checkzone', {'nsd-checkzone.c', 'libnsd.a.d'})

local cfg = {
	logfile='/var/log/nsd.log',  -- just used for man page example
	chrootdir='',
	ratelimit_default='on',
}
for line in iterlines('config.h', 1) do
	local var, val = line:match('^#define (%g+) "(%g+)"$')
	if var then
		cfg[var:lower()] = val
	elseif line:find('^#define RATELIMIT') then
		cfg.ratelimit = 'on'
	elseif line:find('^#define RATELIMIT_DEFAULT_OFF') then
		cfg.ratelimit_default = 'off'
	end
end
local subst = {
	'-e s,@configdir@,'..cfg.configdir..',g',
	'-e s,@zonesdir@,'..cfg.zonesdir..',g',
	'-e s,@chrootdir@,'..cfg.chrootdir..',g',
	'-e s,@pidfile@,'..cfg.pidfile..',g',
	'-e s,@logfile@,'..cfg.logfile..',g',
	'-e s,@dbfile@,'..cfg.dbfile..',g',
	'-e s,@xfrdir@,'..cfg.xfrdir..',g',
	'-e s,@xfrdfile@,'..cfg.xfrdfile..',g',
	'-e s,@zonelistfile@,'..cfg.zonelistfile..',g',
	'-e s,@nsdconfigfile@,'..cfg.configfile..',g',
	'-e s,@ratelimit_default@,'..cfg.ratelimit_default..',g',
	'-e s,@user@,'..cfg.user..',g',
}
if not cfg.ratelimit then
	table.insert(subst, '-e /rrlstart/,/rrlend/d')
end
set('subst', subst)
local function substman(file)
	build('sed', '$outdir/'..file, '$srcdir/'..file..'.in', {expr='$subst'})
	man{'$outdir/'..file}
end

for _, cmd in ipairs{'nsd', 'nsd-checkconf', 'nsd-checkzone'} do
	file('bin/'..cmd, '755', '$outdir/'..cmd)
	substman(cmd..'.8')
end
substman('nsd.conf.5')

fetch 'curl'
