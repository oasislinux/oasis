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

-- src/include/curl/Makefile.am:/^pkginclude_HEADERS
pkg.hdrs = copy('$outdir/include/curl', '$srcdir/include/curl', {
	'curl.h', 'curlver.h', 'easy.h', 'mprintf.h', 'stdcheaders.h', 'multi.h',
	'typecheck-gcc.h', 'system.h', 'urlapi.h', 'options.h', 'header.h', 'websockets.h',
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
		altsvc.c amigaos.c asyn-ares.c asyn-thread.c base64.c bufq.c
		bufref.c c-hyper.c cf-h1-proxy.c cf-h2-proxy.c cf-haproxy.c
		cf-https-connect.c cf-socket.c cfilters.c conncache.c connect.c
		content_encoding.c cookie.c curl_addrinfo.c curl_des.c
		curl_endian.c curl_fnmatch.c curl_get_line.c curl_gethostname.c
		curl_gssapi.c curl_memrchr.c curl_multibyte.c curl_ntlm_core.c
		curl_ntlm_wb.c curl_path.c curl_range.c curl_rtmp.c curl_sasl.c
		curl_sspi.c curl_threads.c curl_trc.c dict.c doh.c dynbuf.c
		dynhds.c easy.c easygetopt.c easyoptions.c escape.c file.c
		fileinfo.c fopen.c formdata.c ftp.c ftplistparser.c getenv.c
		getinfo.c gopher.c hash.c headers.c hmac.c hostasyn.c hostip.c
		hostip4.c hostip6.c hostsyn.c hsts.c http.c http1.c http2.c
		http_aws_sigv4.c http_chunks.c http_digest.c http_negotiate.c
		http_ntlm.c http_proxy.c idn.c if2ip.c imap.c inet_ntop.c
		inet_pton.c krb5.c ldap.c llist.c macos.c md4.c md5.c memdebug.c
		mime.c mprintf.c mqtt.c multi.c netrc.c nonblock.c noproxy.c
		openldap.c parsedate.c pingpong.c pop3.c progress.c psl.c rand.c
		rename.c rtsp.c select.c sendf.c setopt.c sha256.c share.c
		slist.c smb.c smtp.c socketpair.c socks.c socks_gssapi.c
		socks_sspi.c speedcheck.c splay.c strcase.c strdup.c strerror.c
		strtok.c strtoofft.c system_win32.c telnet.c tftp.c timediff.c
		timeval.c transfer.c url.c urlapi.c version.c version_win32.c
		warnless.c ws.c
		vauth/(
			cleartext.c cram.c digest.c digest_sspi.c
			gsasl.c krb5_gssapi.c krb5_sspi.c ntlm.c
			ntlm_sspi.c oauth2.c spnego_gssapi.c
			spnego_sspi.c vauth.c
		)
		vtls/(
			bearssl.c gtls.c hostcheck.c keylog.c mbedtls.c
			mbedtls_threadlock.c openssl.c rustls.c schannel.c
			schannel_verify.c sectransp.c vtls.c wolfssl.c
			x509asn1.c
		)
		vquic/(curl_msh3.c curl_ngtcp2.c curl_quiche.c vquic.c)
		vssh/(libssh.c libssh2.c wolfssh.c)
	)
	$builddir/pkg/bearssl/libbearssl.a
	$builddir/pkg/zlib/libz.a
]])

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
		tool_dirhie.c
		tool_doswin.c
		tool_easysrc.c
		tool_filetime.c
		tool_findfile.c
		tool_formparse.c
		tool_getparam.c
		tool_getpass.c
		tool_help.c
		tool_helpers.c
		tool_ipfs.c
		tool_libinfo.c
		tool_listhelp.c
		tool_main.c
		tool_msgs.c
		tool_operate.c
		tool_operhlp.c
		tool_paramhlp.c
		tool_parsecfg.c
		tool_progress.c
		tool_setopt.c
		tool_sleep.c
		tool_stderr.c
		tool_strdup.c
		tool_urlglob.c
		tool_util.c
		tool_vms.c
		tool_writeout.c
		tool_writeout_json.c
		tool_xattr.c
		var.c
	)
	libcurl.a.d
]])

file('bin/curl', '755', '$outdir/curl')
man{'docs/curl.1'}

fetch 'curl'
