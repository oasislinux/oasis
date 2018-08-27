local arch = config.target.toolchain:match('[^-]*')
cflags{
	'-D _XOPEN_SOURCE=600',
	'-D _DEFAULT_SOURCE',
	'-D SECCOMP_AUDIT_ARCH=AUDIT_ARCH_'..arch:upper(),
	'-I $dir',
	'-I $srcdir',
	'-I $srcdir/openbsd-compat',
	'-I pkg/openbsd/include',
	'-I $builddir/pkg/libressl/include',
	'-I $builddir/pkg/zlib/include',
}

pkg.deps = {
	'pkg/libressl/headers',
	'pkg/zlib/headers',
}

lib('libopenbsd-compat.a', [[openbsd-compat/(
	base64.c basename.c bcrypt_pbkdf.c bindresvport.c blowfish.c daemon.c
	dirname.c explicit_bzero.c fmt_scaled.c freezero.c getcwd.c
	getgrouplist.c getopt_long.c getrrsetbyname.c glob.c inet_aton.c
	inet_ntoa.c inet_ntop.c md5.c mktemp.c pwcache.c readpassphrase.c
	reallocarray.c realpath.c recallocarray.c rmd160.c rresvport.c setenv.c
	setproctitle.c sha1.c sha2.c sigact.c strcasestr.c strlcat.c strlcpy.c
	strmode.c strndup.c strnlen.c strptime.c strsep.c strtoll.c strtonum.c
	strtoull.c strtoul.c timingsafe_bcmp.c vis.c

	arc4random.c bsd-asprintf.c bsd-closefrom.c bsd-cygwin_util.c bsd-err.c
	bsd-flock.c bsd-getpagesize.c bsd-getpeereid.c bsd-malloc.c bsd-misc.c
	bsd-nextstep.c bsd-openpty.c bsd-poll.c bsd-setres_id.c bsd-signal.c
	bsd-snprintf.c bsd-statvfs.c bsd-waitpid.c fake-rfc2553.c
	getrrsetbyname-ldns.c kludge-fd_set.c openssl-compat.c xcrypt.c

	port-aix.c port-irix.c port-linux.c port-solaris.c port-net.c port-uw.c
)]])

-- port-tun.c from openbsd-compat depends on sshbuf-getput-basic.c and ssherr.c
-- from libssh.a, so just include it in libssh.a.
lib('libssh.a', [[
	ssh_api.c
	ssherr.c
	sshbuf.c
	sshkey.c
	sshbuf-getput-basic.c
	sshbuf-misc.c
	sshbuf-getput-crypto.c
	krl.c
	bitmap.c

	ssh-xmss.c
	sshkey-xmss.c
	xmss_commons.c
	xmss_fast.c
	xmss_hash.c
	xmss_hash_address.c
	xmss_wots.c

	authfd.c authfile.c
	canohost.c channels.c cipher.c cipher-aes.c cipher-aesctr.c
	cipher-ctr.c cleanup.c
	compat.c crc32.c fatal.c hostfile.c
	log.c match.c moduli.c nchan.c packet.c opacket.c
	readpass.c ttymodes.c xmalloc.c addrmatch.c
	atomicio.c dispatch.c mac.c uuencode.c misc.c utf8.c
	monitor_fdpass.c rijndael.c ssh-dss.c ssh-ecdsa.c ssh-rsa.c dh.c
	msg.c progressmeter.c dns.c entropy.c gss-genr.c umac.c umac128.c
	ssh-pkcs11.c smult_curve25519_ref.c
	poly1305.c chacha.c cipher-chachapoly.c
	ssh-ed25519.c digest-openssl.c digest-libc.c hmac.c
	sc25519.c ge25519.c fe25519.c ed25519.c verify.c hash.c
	kex.c kexdh.c kexgex.c kexecdh.c kexc25519.c
	kexdhc.c kexgexc.c kexecdhc.c kexc25519c.c
	kexdhs.c kexgexs.c kexecdhs.c kexc25519s.c
	platform-pledge.c platform-tracing.c platform-misc.c
	libopenbsd-compat.a
	$builddir/pkg/(libressl/libcrypto.a.d zlib/libz.a)
]])

exe('ssh', [[
	ssh.c readconf.c clientloop.c sshtty.c
	sshconnect.c sshconnect2.c mux.c
	libssh.a.d
]])
file('bin/ssh', '755', '$outdir/ssh')

cc('sftp-server.c')
cc('sftp-common.c')

exe('sshd', [[
	sshd.c auth-rhosts.c auth-passwd.c
	audit.c audit-bsm.c audit-linux.c platform.c
	sshpty.c sshlogin.c servconf.c serverloop.c
	auth.c auth2.c auth-options.c session.c
	auth2-chall.c groupaccess.c
	auth-bsdauth.c auth2-hostbased.c auth2-kbdint.c
	auth2-none.c auth2-passwd.c auth2-pubkey.c
	monitor.c monitor_wrap.c auth-krb5.c
	auth2-gss.c gss-serv.c gss-serv-krb5.c
	loginrec.c auth-pam.c auth-shadow.c auth-sia.c md5crypt.c
	sftp-server.c.o sftp-common.c.o
	sandbox-null.c sandbox-rlimit.c sandbox-systrace.c sandbox-darwin.c
	sandbox-seccomp-filter.c sandbox-capsicum.c sandbox-pledge.c
	sandbox-solaris.c uidswap.c
	libssh.a.d
]])
file('bin/sshd', '755', '$outdir/sshd')

exe('scp', {'scp.c', 'libssh.a.d'})
file('bin/scp', '755', '$outdir/scp')

exe('ssh-add', {'ssh-add.c', 'libssh.a.d'})
file('bin/ssh-add', '755', '$outdir/ssh-add')

exe('ssh-agent', {'ssh-agent.c', 'ssh-pkcs11-client.c', 'libssh.a.d'})
file('bin/ssh-agent', '755', '$outdir/ssh-agent')

exe('ssh-keygen', {'ssh-keygen.c', 'libssh.a.d'})
file('bin/ssh-keygen', '755', '$outdir/ssh-keygen')

exe('sftp-server', {'sftp-common.c.o', 'sftp-server.c.o', 'sftp-server-main.c', 'libssh.a.d'})
file('libexec/sftp-server', '755', '$outdir/sftp-server')

man{'ssh.1', 'scp.1', 'ssh-add.1', 'ssh-agent.1', 'ssh-keygen.1', 'sshd.8', 'sftp-server.8'}

fetch 'git'
