cflags{
	'-std=c11', '-Wall', '-Wextra', '-Wpedantic',
	'-Wno-maybe-uninitialized',
	'-D _GNU_SOURCE',
	'-isystem $builddir/pkg/libtls-bearssl/include',
	'-isystem $builddir/pkg/netbsd-curses/include',
}

pkg.deps = {
	'pkg/libtls-bearssl/headers',
	'pkg/netbsd-curses/headers',
}

exe('catgirl', [[
	buffer.c
	chat.c
	command.c
	complete.c
	config.c
	edit.c
	filter.c
	handle.c
	irc.c
	log.c
	ui.c
	url.c
	xdg.c
	$builddir/pkg/libtls-bearssl/libtls.a.d
	$builddir/pkg/netbsd-curses/libcurses.a.d
]])
file('bin/catgirl', '755', '$outdir/catgirl')
man{'catgirl.1'}

fetch 'git'
