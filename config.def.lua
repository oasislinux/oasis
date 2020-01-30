local sets = dofile(basedir..'/sets.lua')

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
		platform='x86_64-linux-musl',
		cflags='-O2 -pipe -fpie',
		ldflags='-s -static -pie',
		pie=true
	},

	-- host toolchain and flags
	host={
		cflags='-pipe',
		ldflags='',
	},

	-- output git repository
	repo={
		path='$builddir/root.git',
		flags='--bare',
		tag='tree',
		branch='master',
	},

	-- GPU driver (possible_values: amdgpu intel nouveau)
	-- video_drivers={intel=true}
}
