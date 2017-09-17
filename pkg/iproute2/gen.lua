cflags{
	'-Wall', '-Wformat=2', '-Wmissing-declarations', '-Wmissing-prototypes',
	'-Wold-style-definition', '-Wstrict-prototypes',
	'-D _GNU_SOURCE',
	'-D HAVE_SETNS',
	'-I $srcdir/include',
	'-I $srcdir/misc',
}

lib('libnetlink.a', [[lib/(
	libgenl.c ll_map.c libnetlink.c

	utils.c rt_names.c ll_types.c ll_proto.c ll_addr.c
	inet_proto.c namespace.c json_writer.c
	names.c color.c bpf.c exec.c fs.c
	(dnet ipx mpls)_ntop.c (dnet ipx mpls)_pton.c
)]])

exe('bin/ip', [[ip/(
	ip.c ipaddress.c ipaddrlabel.c iproute.c iprule.c ipnetns.c
	rtm_map.c iptunnel.c ip6tunnel.c tunnel.c ipneigh.c ipntable.c iplink.c
	ipmaddr.c ipmonitor.c ipmroute.c ipprefix.c iptuntap.c iptoken.c
	ipxfrm.c xfrm_state.c xfrm_policy.c xfrm_monitor.c iplink_dummy.c
	iplink_ifb.c iplink_nlmon.c iplink_team.c iplink_vcan.c iplink_vxcan.c
	iplink_vlan.c link_veth.c link_gre.c iplink_can.c iplink_xdp.c
	iplink_macvlan.c ipl2tp.c link_vti.c link_vti6.c
	iplink_vxlan.c tcp_metrics.c iplink_ipoib.c ipnetconf.c link_ip6tnl.c
	link_iptnl.c link_gre6.c iplink_bond.c iplink_bond_slave.c iplink_hsr.c
	iplink_bridge.c iplink_bridge_slave.c ipfou.c iplink_ipvlan.c
	iplink_geneve.c iplink_vrf.c iproute_lwtunnel.c ipmacsec.c ipila.c
	ipvrf.c iplink_xstats.c ipseg6.c
) libnetlink.a]])
file('bin/ip', '755', '$outdir/bin/ip')

exe('bin/bridge', [[
	bridge/(bridge.c fdb.c monitor.c link.c mdb.c vlan.c)
	libnetlink.a
]])
file('bin/bridge', '755', '$outdir/bin/bridge')

yacc('ssfilter', '$srcdir/misc/ssfilter.y')
exe('bin/ss', {'misc/ss.c', '$outdir/ssfilter.tab.c', 'libnetlink.a'})
file('bin/ss', '755', '$outdir/bin/ss')

man(paths[[man/man8/(
	bridge ip ss
	ip-(
		addrlabel fou gue l2tp macsec maddress monitor mroute neighbour
		netconf netns ntable rule sr tcp_metrics token tunnel vrf xfrm
	)
).8]])
for _, name in ipairs{'ip-address', 'ip-link', 'ip-route'} do
	local out = '$outdir/'..name..'.8'
	build('sed', out, '$srcdir/man/man8/'..name..'.8.in', {
		expr='s,@SYSCONFDIR@,/etc,g'
	})
	man{out}
end

fetch 'git'
