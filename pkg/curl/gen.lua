cflags{
	'-std=c99', '-Wall', '-Wpedantic', '-Wno-maybe-uninitialized',
	'-D _GNU_SOURCE',
	'-D HAVE_CONFIG_H',
	'-D BUILDING_LIBCURL',
	'-D CURL_STATICLIB',
	'-I $outdir',
	'-I $outdir/include/curl',
	'-I $outdir/include',
	'-I $srcdir/lib',
	'-I $srcdir/lib/curlx',
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
		altsvc.c amigaos.c asyn-ares.c asyn-base.c asyn-thrdd.c bufq.c
		bufref.c cf-h1-proxy.c cf-h2-proxy.c cf-haproxy.c
		cf-https-connect.c cf-socket.c cfilters.c conncache.c connect.c
		content_encoding.c cookie.c cshutdn.c  curl_addrinfo.c curl_des.c
		curl_endian.c curl_fnmatch.c curl_get_line.c curl_gethostname.c
		curl_gssapi.c curl_memrchr.c curl_ntlm_core.c
		curl_range.c curl_rtmp.c curl_sasl.c curl_sha512_256.c
		curl_sspi.c curl_threads.c curl_trc.c cw-out.c cw-pause.c
		dict.c doh.c dynhds.c easy.c easygetopt.c easyoptions.c
		escape.c fake_addrinfo.c file.c fileinfo.c fopen.c formdata.c ftp.c
		ftplistparser.c getenv.c getinfo.c gopher.c hash.c headers.c
		hmac.c hostip.c hostip4.c hostip6.c hsts.c
		http.c http1.c http2.c http_aws_sigv4.c http_chunks.c
		http_digest.c http_negotiate.c http_ntlm.c http_proxy.c httpsrr.c
		idn.c if2ip.c imap.c inet_ntop.c krb5.c ldap.c llist.c
		macos.c md4.c md5.c memdebug.c mime.c mprintf.c mqtt.c multi.c
		multi_ev.c netrc.c noproxy.c openldap.c parsedate.c pingpong.c
		pop3.c progress.c psl.c rand.c rename.c request.c rtsp.c
		select.c sendf.c setopt.c sha256.c share.c slist.c smb.c smtp.c
		socketpair.c socks.c socks_gssapi.c socks_sspi.c speedcheck.c
		splay.c strcase.c strdup.c strequal.c strerror.c
		system_win32.c telnet.c tftp.c transfer.c uint-bset.c uint-hash.c
		uint-spbset.c uint-table.c url.c urlapi.c version.c ws.c
		curlx/(
			base64.c dynbuf.c inet_pton.c multibyte.c nonblock.c 
			strparse.c timediff.c timeval.c version_win32.c 
			warnless.c winapi.c
		)
		vauth/(
			cleartext.c cram.c digest.c digest_sspi.c gsasl.c krb5_gssapi.c
			krb5_sspi.c ntlm.c ntlm_sspi.c oauth2.c spnego_gssapi.c
			spnego_sspi.c vauth.c
		)
		vtls/(
			bearssl.c cipher_suite.c gtls.c hostcheck.c keylog.c mbedtls.c
			mbedtls_threadlock.c openssl.c rustls.c schannel.c
			schannel_verify.c sectransp.c vtls.c vtls_scache.c vtls_spack.c
			wolfssl.c x509asn1.c
		)
		vquic/(
			curl_msh3.c curl_ngtcp2.c curl_osslq.c curl_quiche.c vquic.c
			vquic-tls.c
			)
		vssh/(libssh.c libssh2.c curl_path.c wolfssh.c)
	)
	$builddir/pkg/bearssl/libbearssl.a
	$builddir/pkg/zlib/libz.a
]])

-- src/src/Makefile.inc:/^CURL_CFILES
exe('curl', [[
	src/(
		config2setopts.c
		slist_wc.c
		terminal.c
		tool_bname.c
		tool_cb_dbg.c
		tool_cb_hdr.c
		tool_cb_prg.c
		tool_cb_rea.c
		tool_cb_see.c
		tool_cb_soc.c
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
		tool_ssls.c
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
man{'$dir/curl.1'}

fetch 'curl'
