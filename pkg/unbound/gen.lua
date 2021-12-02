cflags{
	'-I $dir',
	'-I $srcdir',
	'-isystem $builddir/pkg/bearssl/include',
}
pkg.deps = {
	'pkg/bearssl/headers',
}

exe('unbound', [[
	daemon/(
		acl_list.c daemon.c
		stats.c unbound.c
		worker.c
	)
	util/shm_side/shm_main.c
	sldns/(
		keyraw.c sbuffer.c wire2str.c parse.c parseutil.c rrdef.c
		str2wire.c
	)
	util/(
		edns.c
		config_file.c
		configparser.c
		configlexer.c
		as112.c
		timehist.c
		log.c
		locks.c
		tube.c
		fptr_wlist.c
		netevent.c
		regional.c
		ub_event.c
		net_help.c
		rtt.c
		mini_event.c
		tcp_conn_limit.c
		rbtree.c
		data/(
			msgparse.c
			msgencode.c
			dname.c
			msgreply.c
			packed_rrset.c
		)
		storage/(
			slabhash.c
			lruhash.c
			dnstree.c
			lookup3.c
		)
		alloc.c
		random.c
		module.c
	)
	iterator/(
		iter_utils.c
		iter_resptype.c
		iter_hints.c
		iter_fwd.c
		iter_delegpt.c
		iterator.c
		iter_scrub.c
		iter_priv.c
		iter_donotq.c
	)
	dns64/dns64.c
	respip/respip.c
	services/(
		rpz.c
		view.c
		outside_network.c
		authzone.c
		outbound_list.c
		modstack.c
		listen_dnsport.c
		cache/(dns.c rrset.c infra.c)
		mesh.c
		localzone.c
	)
	validator/(
		autotrust.c
		validator.c
		val_anchor.c
		val_secalgo.c
		val_sigcrypt.c
		val_nsec.c
		val_nsec3.c
		val_utils.c
		val_kentry.c
		val_kcache.c
		val_neg.c
	)
	$builddir/pkg/bearssl/libbearssl.a
]])

file('bin/unbound', '755', '$outdir/unbound')

for _, name in ipairs{'unbound.8', 'unbound.conf.5'} do
	build('sed', '$outdir/'..name, '$srcdir/doc/'..name..'.in', {
		expr={
			[[-e 's/@date@/Dec 10, 2021/']],
			[[-e 's,@version@,1.14.0,']],
			[[-e 's,@ub_conf_file@,/etc/unbound/unbound.conf,']],
			[[-e 's,@UNBOUND_CHROOT_DIR@,/etc/unbound,']],
			[[-e 's,@UNBOUND_USERNAME@,unbound,']],
			[[-e 's,@UNBOUND_RUN_DIR@,/etc/unbound,']],
			[[-e 's,@UNBOUND_PIDFILE@,,']],
			[[-e 's,@DNSTAP_SOCKET_PATH@,,']],
		},
	})
	man{'$outdir/'..name}
end

fetch 'git'
