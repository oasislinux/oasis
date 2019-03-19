cflags{
	'-D HAVE_CONFIG_H',
	[[-D 'SYSCONFDIR="/etc"']],
	'-I $dir',
	'-I $builddir/pkg/libressl/include',
}

exe('msmtp', [[
	src/(
		conf.c
		list.c
		msmtp.c
		net.c
		netrc.c
		readbuf.c
		smtp.c
		stream.c
		tools.c
		xalloc.c
		aliases.c
		password.c

		tls.c

		base64.c md5.c md5-apps.c
	)
	$builddir/pkg/libressl/(libssl.a.d libcrypto.a.d)
]], {'pkg/libressl/headers'})

file('bin/msmtp', '755', '$outdir/msmtp')
man{'doc/msmtp.1'}

fetch 'git'
