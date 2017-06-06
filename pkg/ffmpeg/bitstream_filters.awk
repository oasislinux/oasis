/^#define/ && $3 {
	cfg[$2] = 1
}

func bsf(name) {
	if (cfg["CONFIG_" toupper(name) "_BSF"])
		print "&ff_" name "_bsf,"
}

END {
	print "static const AVBitStreamFilter *bitstream_filters[] = {"
	bsf("aac_adtstoasc")
	bsf("chomp")
	bsf("dump_extradata")
	bsf("dca_core")
	bsf("extract_extradata")
	bsf("h264_mp4toannexb")
	bsf("hevc_mp4toannexb")
	bsf("imx_dump_header")
	bsf("mjpeg2jpeg")
	bsf("mjpega_dump_header")
	bsf("mp3_header_decompress")
	bsf("mpeg4_unpack_bframes")
	bsf("mov2textsub")
	bsf("noise")
	bsf("remove_extradata")
	bsf("text2movsub")
	bsf("vp9_superframe")
	print "NULL};"
}
