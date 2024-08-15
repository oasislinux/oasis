{
	version = $0
}

END {
	printf("#define VERSION \"%s\"\n", version)
	print("#define BUILDDATE \"UNKNOWN\"")
	print("#define MPVCOPYRIGHT \"Copyright © 2000-2024 mpv/MPlayer/mplayer2 projects\"")
}
