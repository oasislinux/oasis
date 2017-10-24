local sets = dofile 'sets.lua'

return {
	-- build output directory
	builddir='out',

	-- package/file selection
	fs={
                -- Each entry contains a list of packages, a list of patterns to
                -- include, and a list of patterns to exclude. If no patterns
                -- are specified, all files from the package are included.
		{sets.core, exclude={'^include/', '^lib/.*%.a$'}},
	},

	-- target toolchain and flags
	target={
		toolchain='x86_64-linux-musl',
		cflags='-O2 -pipe',
		cxxflags='$target_cflags',
		ldflags='-s -static',
	},

	-- host toolchain and flags
	host={
		toolchain='default',
		cflags='-pipe',
		cxxflags='$host_cflags',
		ldflags='',
	},

	-- output git repository
	repo={
		path='$builddir/root.git',
		flags='--bare',
		tag='tree',
		branch='master',
	},

	-- TLS implementation (possible_values: libressl bearssl)
	tls='libressl',

	-- GPU driver (possible_values: intel nouveau)
	-- video_drivers={intel=true}
}
