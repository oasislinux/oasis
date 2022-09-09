cflags{
	'-D HAVE_CONFIG_H',
	([[-D 'SYSCONFDIR="%s/etc"']]):format(config.prefix),
	'-I $dir',
	'-isystem $builddir/pkg/libtls-bearssl/include',
}

pkg.deps = {
	'pkg/libtls-bearssl/headers',
}

exe('msmtp', [[
	src/(
		conf.c
		eval.c
		list.c
		md5.c
		md5-apps.c
		msgid.c
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
		base64.c

		mtls.c
		mtls-libtls.c
	)
	$builddir/pkg/libtls-bearssl/libtls.a.d
]])

file('bin/msmtp', '755', '$outdir/msmtp')
man{'doc/msmtp.1'}

fetch 'git'
