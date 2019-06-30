{
	version = $0
}

END {
	printf("#define VERSION \"%s\"\n", version)
	print("#define NO_BUILD_TIMESTAMPS")
	print("#define MPVCOPYRIGHT \"Copyright © 2000-2018 mpv/MPlayer/mplayer2 projects\"")
}
