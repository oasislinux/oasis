cflags{
	'-include $dir/config.h',
	'-I $srcdir/src/utils',
	'-I $srcdir/src',
	'-isystem $builddir/pkg/bearssl/include',
	'-isystem $builddir/pkg/libnl/include',
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.deps = {
	'pkg/bearssl/headers',
	'pkg/libnl/headers',
	'pkg/linux-headers/headers',
}

lib('libcommon.a', 'src/utils/(common.c config.c eloop.c os_unix.c wpabuf.c wpa_debug.c)')

exe('bin/wpa_supplicant', [[
	src/ap/(
		wpa_auth.c
		wpa_auth_ie.c
		pmksa_cache_auth.c
	)
	src/common/(
		ctrl_iface_common.c
		hw_features_common.c
		ieee802_11_common.c
		wpa_common.c
	)
	src/crypto/(
		aes-internal-dec.c
		aes-internal-enc.c
		aes-internal.c
		aes-unwrap.c
		aes-wrap.c
		aes-omac1.c
		crypto_bearssl.c
		random.c
		rc4.c
		sha1-pbkdf2.c
		sha1-prf.c
		sha256-prf.c
		tls_none.c
	)
	src/drivers/(
		driver_common.c
		driver_nl80211.c
		driver_nl80211_capa.c
		driver_nl80211_event.c
		driver_nl80211_monitor.c
		driver_nl80211_scan.c
		drivers.c
		linux_ioctl.c
		netlink.c
		rfkill.c
	)
	src/l2_packet/l2_packet_linux.c
	src/rsn_supp/(
		pmksa_cache.c
		preauth.c
		wpa.c
		wpa_ie.c
	)
	src/utils/(bitfield.c ip_addr.c crc32.c radiotap.c)
	wpa_supplicant/(
		bss.c
		config.c
		config_file.c
		ctrl_iface.c
		ctrl_iface_unix.c
		eap_register.c
		events.c
		ibss_rsn.c
		main.c
		notify.c
		op_classes.c
		rrm.c
		twt.c
		robust_av.c
		scan.c
		sme.c
		wmm_ac.c
		wpa_supplicant.c
		wpas_glue.c
		bssid_ignore.c
	)
	libcommon.a
	$builddir/pkg/bearssl/libbearssl.a
	$builddir/pkg/libnl/(libnl-3.a libnl-genl-3.a)
]])
file('bin/wpa_supplicant', '755', '$outdir/bin/wpa_supplicant')

exe('bin/wpa_cli', [[
	src/common/(cli.c wpa_ctrl.c)
	src/utils/edit_simple.c
	wpa_supplicant/wpa_cli.c
	libcommon.a
]])
file('bin/wpa_cli', '755', '$outdir/bin/wpa_cli')

man(paths[[wpa_supplicant/doc/docbook/(wpa_cli.8 wpa_supplicant.8 wpa_supplicant.conf.5)]])

fetch 'curl'
