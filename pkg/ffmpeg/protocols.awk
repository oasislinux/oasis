/^#define/ && $3 {
	cfg[$2] = 1
}

func proto(name) {
	if (cfg["CONFIG_" toupper(name) "_PROTOCOL"])
		print "&ff_" name "_protocol,"
}

END {
	print "static const URLProtocol *url_protocols[] = {"
	proto("async")
	proto("bluray")
	proto("cache")
	proto("concat")
	proto("crypto")
	proto("data")
	proto("ffrtmpcrypt")
	proto("ffrtmphttp")
	proto("file")
	proto("ftp")
	proto("gopher")
	proto("hls")
	proto("http")
	proto("httpproxy")
	proto("https")
	proto("icecast")
	proto("mmsh")
	proto("mmst")
	proto("md5")
	proto("pipe")
	proto("prompeg")
	proto("rtmp")
	proto("rtmpe")
	proto("rtmps")
	proto("rtmpt")
	proto("rtmpte")
	proto("rtmpts")
	proto("rtp")
	proto("sctp")
	proto("srtp")
	proto("subfile")
	proto("tee")
	proto("tcp")
	proto("tls_gnutls")
	proto("tls_schannel")
	proto("tls_securetransport")
	proto("tls_openssl")
	proto("udp")
	proto("udplite")
	proto("unix")
	proto("librtmp")
	proto("librtmpe")
	proto("librtmps")
	proto("librtmpt")
	proto("librtmpte")
	proto("libssh")
	proto("libsmbclient")
	print "NULL};"
}
