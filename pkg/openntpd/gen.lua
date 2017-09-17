cflags{
	'-D _GNU_SOURCE',
	'-include $dir/config.h',
	'-I include',
	'-I $srcdir/src',
	'-I $srcdir/include',
	'-I pkg/openbsd/include',
	'-I $builddir/pkg/libressl/include',
}

yacc('parse', '$srcdir/src/parse.y')
exe('ntpd', [[
	src/(
		client.c
		config.c
		constraint.c
		control.c
		fake-sensors.c
		log.c
		ntp.c
		ntp_dns.c
		ntp_msg.c
		ntpd.c
		server.c
		util.c
	)
	compat/(
		adjfreq_linux.c
		closefrom.c
		freezero.c
		imsg.c
		imsg-buffer.c
		md5.c
		progname.c
		setproctitle.c
	)
	$outdir/parse.tab.c
	$builddir/pkg/(
		libressl/(libcrypto.a.d libtls.a.d)
		openbsd/libbsd.a.d
	)
]], {'pkg/libressl/headers'})
file('bin/ntpd', '755', '$outdir/ntpd')
sym('bin/ntpctl', 'ntpd')
man{'src/ntpd.conf.5', 'src/ntpd.8', 'src/ntpctl.8'}

fetch 'curl'
