cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-D _XOPEN_SOURCE=700',
	[[-D 'SFEED_THEME="themes/mono.h"']],
	'-isystem $builddir/pkg/netbsd-curses/include',
}

pkg.deps = {'pkg/netbsd-curses/headers'}

exe('sfeed_curses', {'sfeed_curses.c', '$builddir/pkg/netbsd-curses/libcurses.a.d'})
file('bin/sfeed_curses', '755', '$outdir/sfeed_curses')
file('bin/sfeed_content', '755', '$srcdir/sfeed_content')
file('bin/sfeed_markread', '755', '$srcdir/sfeed_markread')

man{'sfeed_curses.1', 'sfeed_content.1', 'sfeed_markread.1'}

fetch 'git'
