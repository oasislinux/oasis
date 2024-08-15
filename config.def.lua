local sets = dofile(basedir..'/sets.lua')

return {
	-- build output directory
	builddir='out',

	-- install prefix
	prefix='',

	-- compress man pages
	gzman=true,

	-- package/file selection
	fs={
                -- Each entry contains a list of packages, a list of patterns
                -- matching files to include from those packages, and a list of
                -- patterns matching files to exclude. If no patterns are
                -- specified, all files from the package are included.
		{sets.core, exclude={'^include/', '^lib/.*%.a$'}},

		-- You may also specify a list of patterns to include or exclude
		-- for any packages not matching any entries. If no patterns are
		-- specified, all files from the package are excluded.
		-- include={...}, exclude={...},
	},

	-- target toolchain and flags
	target={
		platform='x86_64-linux-musl',
		cflags='-Os -fPIE -pipe -Werror=implicit-function-declaration',
		ldflags='-s -static-pie',
	},

	-- host toolchain and flags
	host={
		cflags='-O2 -pipe',
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
