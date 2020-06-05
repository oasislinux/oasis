cflags{
	[[-D 'VERSION="0.7"']],
	'-I $dir',
	'-isystem $builddir/pkg/fontconfig/include',
	'-isystem $builddir/pkg/libxkbcommon/include',
	'-isystem $builddir/pkg/linux-headers/include',
	'-isystem $builddir/pkg/pixman/include',
	'-isystem $builddir/pkg/wayland/include',
	'-isystem $builddir/pkg/wayland-protocols/include',
	'-isystem $builddir/pkg/wld/include',
}

pkg.deps = {
	'pkg/fontconfig/headers',
	'pkg/libxkbcommon/headers',
	'pkg/linux-headers/headers',
	'pkg/pixman/headers',
	'pkg/wayland/headers',
	'pkg/wayland-protocols/headers',
	'pkg/wld/headers',
}

exe('st', [[st.c $builddir/pkg/(
	libxkbcommon/libxkbcommon.a
	wayland/libwayland-client.a.d
	wayland/libwayland-cursor.a.d
	wayland-protocols/xdg-shell-protocol.c.o
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
