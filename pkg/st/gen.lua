cflags{
	[[-D 'VERSION="0.7"']],
	'-I $dir',
	'-I pkg/fontconfig/src',
	'-I pkg/libxkbcommon/src',
	'-I $builddir/pkg/pixman/include',
	'-I $builddir/pkg/wayland/include',
	'-I $builddir/pkg/wayland-protocols/include',
	'-I $builddir/pkg/wld/include',
}

pkg.deps = {
	'pkg/fontconfig/fetch',
	'pkg/libxkbcommon/fetch',
	'pkg/pixman/headers',
	'pkg/wayland/headers',
	'pkg/wayland-protocols/headers',
	'pkg/wld/headers',
}

exe('st', [[st.c $builddir/pkg/(
	libxkbcommon/libxkbcommon.a
	wayland/libwayland-client.a.d
	wayland/libwayland-cursor.a.d
	wayland-protocols/xdg-shell-unstable-v5-protocol.c.o
	wld/libwld.a.d
)]])
file('bin/st', '755', '$outdir/st')
man{'st.1'}

local terminfo = {'s/st', 's/st-256color'}
build('tic', expand{'$outdir/', terminfo}, '$srcdir/st.info', {
	ticflags='-x -o $outdir',
})
for _, t in ipairs(terminfo) do
	file('share/terminfo/'..t, '644', '$outdir/'..t)
end

fetch 'git'
