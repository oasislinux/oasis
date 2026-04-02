/^VERSION = /    { version = $3 }
/^PATCHLEVEL = / { patchlevel = $3 }
/^SUBLEVEL = /   { sublevel = $3 }

END {
	print "#define LINUX_VERSION_CODE " (version * 65536 + patchlevel * 256 + sublevel)
	print "#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c)))"
	print "#define LINUX_VERSION_MAJOR " version
	print "#define LINUX_VERSION_PATCHLEVEL " patchlevel
	print "#define LINUX_VERSION_SUBLEVEL " sublevel
}
