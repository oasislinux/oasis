cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-D _XOPEN_SOURCE=700',
	[[-D 'SFEED_THEME="themes/mono.h"']],
	'-isystem $builddir/pkg/netbsd-curses/include',
}

lib('libutil.a', {'util.c', 'xml.c'})

local tools = {
	'sfeed',
	'sfeed_opml_import',
	'sfeed_plain',
	'sfeed_web',
	'sfeed_xmlenc',
}
for _, tool in ipairs(tools) do
	exe(tool, {tool..'.c', 'libutil.a'})
	file('bin/'..tool, '755', '$outdir/'..tool)
	man{tool..'.1'}
end

exe('sfeed_curses', {
	'sfeed_curses.c',
	'libutil.a',
	'$builddir/pkg/netbsd-curses/libcurses.a.d',
}, 'pkg/netbsd-curses/headers')
file('bin/sfeed_curses', '755', '$outdir/sfeed_curses')
man{'sfeed_curses.1'}

local scripts = {
	'sfeed_content',
	'sfeed_markread',
	'sfeed_opml_export',
	'sfeed_update',
}
for _, script in ipairs(scripts) do
	file('bin/'..script, '755', '$srcdir/'..script)
	man{script..'.1'}
end

man{'sfeedrc.5'}

fetch 'git'
