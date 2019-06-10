local sets = dofile 'sets.lua'
return {
	builddir='out',
	fs={
		{
			sets.core, sets.extra, sets.desktop, sets.devel, sets.media,
			exclude={'^include/', '^lib/.*%.a$'},
		},
	},
	target={toolchain='default', cflags='-O2 -pipe -U _FORTIFY_SOURCE', cxxflags='', ldflags='-s -static', pie=true},
	host={toolchain='default', cflags='-O2 -pipe', cxxflags='', ldflags='-s'},
	repo={path='$builddir/root.git', flags='--bare', tag='tree', branch='oasis'},
}
