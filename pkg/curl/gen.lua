cflags{
	'-std=c99', '-Wall', '-Wpedantic', '-Wno-maybe-uninitialized',
	'-D _DEFAULT_SOURCE',
	'-D HAVE_CONFIG_H',
	'-D BUILDING_LIBCURL',
	'-D CURL_STATICLIB',
	'-I $outdir',
	'-I $outdir/include/curl',
	'-I $outdir/include',
	'-I $srcdir/lib',
	'-I $srcdir/src',
	'-isystem $builddir/pkg/bearssl/include',
	'-isystem $builddir/pkg/linux-headers/include',
	'-isystem $builddir/pkg/zlib/include',
}

build('cat', '$outdir/curl_config.h', {
	'$dir/curl_config.h',
	'$builddir/probe/SIZEOF_LONG',
	'$builddir/probe/SIZEOF_SIZE_T',
	'$builddir/probe/SIZEOF_TIME_T',
})

pkg.hdrs = copy('$outdir/include/curl', '$srcdir/include/curl', {
	'curl.h',
	'curlver.h',
	'easy.h',
	'mprintf.h',
	'stdcheaders.h',
	'multi.h',
	'typecheck-gcc.h',
	'system.h',
	'urlapi.h',
})
pkg.deps = {
	'$outdir/curl_config.h',
	'$gendir/headers',
	'pkg/bearssl/headers',
	'pkg/linux-headers/headers',
	'pkg/zlib/headers',
}

-- src/lib/Makefile.inc:/^CSOURCES
lib('libcurl.a', [[
	lib/(
		altsvc.c amigaos.c asyn-ares.c asyn-thread.c base64.c
		conncache.c connect.c content_encoding.c cookie.c curl_addrinfo.c
		curl_ctype.c curl_des.c curl_endian.c curl_fnmatch.c curl_get_line.c
		curl_gethostname.c curl_gssapi.c curl_memrchr.c curl_multibyte.c
		curl_ntlm_core.c curl_ntlm_wb.c curl_path.c curl_range.c curl_rtmp.c
		curl_sasl.c curl_sspi.c curl_threads.c dict.c dotdot.c easy.c escape.c
		file.c fileinfo.c formdata.c ftp.c url.c ftplistparser.c getenv.c getinfo.c
		gopher.c hash.c hmac.c hostasyn.c hostcheck.c hostip.c hostip4.c hostip6.c
		hostsyn.c http.c http2.c http_chunks.c http_digest.c http_negotiate.c
		http_ntlm.c http_proxy.c idn_win32.c if2ip.c imap.c inet_ntop.c inet_pton.c
		krb5.c ldap.c llist.c md4.c md5.c memdebug.c mime.c mprintf.c mqtt.c
		multi.c netrc.c non-ascii.c nonblock.c openldap.c parsedate.c pingpong.c
		pop3.c progress.c psl.c doh.c rand.c rename.c rtsp.c security.c select.c
		sendf.c setopt.c sha256.c share.c slist.c smb.c smtp.c socketpair.c socks.c
		socks_gssapi.c socks_sspi.c speedcheck.c splay.c strcase.c strdup.c
		strerror.c strtok.c strtoofft.c system_win32.c telnet.c tftp.c timeval.c
		transfer.c urlapi.c version.c warnless.c wildcard.c x509asn1.c
		vauth/(
			cleartext.c cram.c digest.c
			digest_sspi.c krb5_gssapi.c krb5_sspi.c ntlm.c
			ntlm_sspi.c oauth2.c spnego_gssapi.c spnego_sspi.c
			vauth.c
		)
		vtls/(
			bearssl.c gskit.c gtls.c mbedtls.c
			mbedtls_threadlock.c mesalink.c nss.c openssl.c
			schannel.c schannel_verify.c sectransp.c vtls.c
			wolfssl.c
		)
		vquic/(ngtcp2.c quiche.c)
		vssh/(libssh.c libssh2.c wolfssh.c)
	)
	$builddir/pkg/bearssl/libbearssl.a
	$builddir/pkg/zlib/libz.a
]])

build('cc', '$outdir/tool_hugehelp.c.o', {
	'$dir/tool_hugehelp.c', '||', '$gendir/deps', '$srcdir/src/tool_hugehelp.h',
})

-- src/src/Makefile.inc:/^CURL_CFILES
exe('curl', [[
	src/(
		slist_wc.c
		tool_binmode.c
		tool_bname.c
		tool_cb_dbg.c
		tool_cb_hdr.c
		tool_cb_prg.c
		tool_cb_rea.c
		tool_cb_see.c
		tool_cb_wrt.c
		tool_cfgable.c
		tool_convert.c
		tool_dirhie.c
		tool_doswin.c
		tool_easysrc.c
		tool_filetime.c
		tool_formparse.c
		tool_getparam.c
		tool_getpass.c
		tool_help.c
		tool_helpers.c
		tool_homedir.c
		tool_libinfo.c
		tool_main.c
		tool_metalink.c
		tool_msgs.c
		tool_operate.c
		tool_operhlp.c
		tool_panykey.c
		tool_paramhlp.c
		tool_parsecfg.c
		tool_progress.c
		tool_strdup.c
		tool_setopt.c
		tool_sleep.c
		tool_urlglob.c
		tool_util.c
		tool_vms.c
		tool_writeout.c
		tool_writeout_json.c
		tool_xattr.c
	)
	tool_hugehelp.c.o
	libcurl.a.d
]])

file('bin/curl', '755', '$outdir/curl')
man{'docs/curl.1'}

fetch 'curl'
