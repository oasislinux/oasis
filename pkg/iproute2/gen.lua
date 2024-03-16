cflags{
	'-Wall', '-Wformat=2', '-Wmissing-declarations', '-Wmissing-prototypes',
	'-Wold-style-definition', '-Wstrict-prototypes', '-Wno-maybe-uninitialized',
	'-Wno-format-truncation', '-Wno-stringop-overflow',
	'-Wno-cpp',  -- we don't have libmnl
	'-D _GNU_SOURCE',
	'-D HAVE_SETNS',
	'-D HAVE_HANDLE_AT',
	[[-D 'CONF_USR_DIR="/share/iproute2"']],
	[[-D 'CONF_ETC_DIR="/etc/iproute2"']],
	[[-D 'NETNS_RUN_DIR="/run/netns"']],
	[[-D 'NETNS_RUN_DIR="/etc/netns"']],
	'-D CONF_COLOR:=COLOR_OPT_AUTO',
	'-I $srcdir/include',
	'-I $srcdir/include/uapi',
	'-I $srcdir/misc',
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.deps = {
	'pkg/linux-headers/headers',
}

lib('libnetlink.a', [[lib/(
	libgenl.c libnetlink.c

	utils.c utils_math.c rt_names.c ll_map.c ll_types.c ll_proto.c ll_addr.c
	inet_proto.c namespace.c json_writer.c json_print.c json_print_math.c
	names.c color.c bpf_legacy.c bpf_glue.c exec.c fs.c cg_map.c ppp_proto.c
	ax25_ntop.c
	rose_ntop.c
	mpls_ntop.c mpls_pton.c
	netrom_ntop.c
)]])

exe('bin/ip', [[ip/(
	ip.c ipaddress.c ipaddrlabel.c iproute.c iprule.c ipnetns.c
	rtm_map.c iptunnel.c ip6tunnel.c tunnel.c ipneigh.c ipntable.c iplink.c
	ipmaddr.c ipmonitor.c ipmroute.c ipprefix.c iptuntap.c iptoken.c
	ipxfrm.c xfrm_state.c xfrm_policy.c xfrm_monitor.c iplink_dummy.c
	iplink_ifb.c iplink_nlmon.c iplink_team.c iplink_vcan.c iplink_vxcan.c
	iplink_vlan.c link_veth.c link_gre.c iplink_can.c iplink_xdp.c
	iplink_macvlan.c ipl2tp.c link_vti.c link_vti6.c link_xfrm.c
	iplink_vxlan.c tcp_metrics.c iplink_ipoib.c ipnetconf.c link_ip6tnl.c
	link_iptnl.c link_gre6.c iplink_bond.c iplink_bond_slave.c iplink_hsr.c
	iplink_bridge.c iplink_bridge_slave.c iplink_dsa.c ipfou.c iplink_ipvlan.c
	iplink_geneve.c iplink_vrf.c iproute_lwtunnel.c ipmacsec.c ipila.c
	ipvrf.c iplink_xstats.c ipseg6.c iplink_netdevsim.c iplink_rmnet.c
	ipnexthop.c ipmptcp.c iplink_bareudp.c iplink_wwan.c ipioam6.c
	iplink_amt.c iplink_batadv.c iplink_gtp.c iplink_virt_wifi.c
	iplink_netkit.c ipstats.c
) libnetlink.a]])
file('bin/ip', '755', '$outdir/bin/ip')

exe('bin/bridge', [[
	bridge/(bridge.c fdb.c monitor.c link.c mdb.c vlan.c vni.c)
	libnetlink.a
]])
file('bin/bridge', '755', '$outdir/bin/bridge')

yacc('ssfilter', '$srcdir/misc/ssfilter.y')
exe('bin/ss', {'misc/ss.c', 'misc/ssfilter_check.c', '$outdir/ssfilter.tab.c', 'libnetlink.a'})
file('bin/ss', '755', '$outdir/bin/ss')

man(paths[[man/man8/(
	bridge ip ss
	ip-(
		addrlabel fou gue l2tp macsec maddress monitor mroute neighbour
		netconf ntable rule sr tcp_metrics token tunnel vrf xfrm
	)
).8]])
for _, name in ipairs{'ip-address', 'ip-link', 'ip-netns', 'ip-route'} do
	local out = '$outdir/'..name..'.8'
	build('sed', out, '$srcdir/man/man8/'..name..'.8.in', {
		expr={
			'-e s,@NETNS_ETC_DIR@,/etc/netns,g',
			'-e s,@NETNS_RUN_DIR@,/run/netns,g',
			'-e s,@SYSCONF_ETC_DIR@,/etc/iproute2,g',
			'-e s,@SYSCONF_USR_DIR@,/share/iproute2,g',
		},
	})
	man{out}
end

fetch 'git'
