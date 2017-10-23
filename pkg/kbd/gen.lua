cflags{
	[[-D 'DATADIR="/share/kbd"']],
	'-I $dir',
	'-I $srcdir',
	'-I $srcdir/src',
	'-I $srcdir/src/libkeymap',
	'-I $srcdir/src/libkeymap/keymap',
}

lib('libcommon.a', 'src/(getfd.c xmalloc.c kbd_error.c)')
lib('libfont.a', 'src/(kdfontop.c kdmapop.c loadunimap.c psffontop.c utf8.c)')
lib('libkeymap.a', [[src/libkeymap/(
	analyze.c
	array.c
	common.c
	diacr.c
	dump.c
	findfile.c
	func.c
	kernel.c
	kmap.c
	ksyms.c
	loadkeys.c
	modifiers.c
	parser.c
	summary.c
)]])

-- old: loadunimap mapscrn
-- optional: clrunmap getunimap setlogcons setvesablank setpalette screendump
-- i386/x86_64 only: resizecons
-- ubase: chvt

local function x(cmd, section, subst, srcs)
	if not srcs then
		srcs = 'src/'..cmd..'.c'
	end
	exe(cmd, {srcs, 'libcommon.a', 'libfont.a', 'libkeymap.a'})
	file('bin/'..cmd, '755', '$outdir/'..cmd)
	if not section then
		return
	end
	local manpage = string.format('docs/man/man%s/%s.%s', section, cmd, section)
	if subst then
		local out = string.format('$outdir/%s.%s', cmd, section)
		build('sed', out, '$srcdir/'..manpage..'.in', {expr='s,@DATADIR@,/share/kbd,g'})
		manpage = out
	end
	man{manpage}
end

x('deallocvt',       '1')
x('dumpkeys',        '1', true)
x('fgconsole',       '1')
x('getkeycodes',     '8')
x('kbd_mode',        '1')
x('kbdinfo')
x('loadkeys',        '1', true)
x('openvt',          '1')
x('psfxtable',       '1')
x('setfont',         '8', true, {'src/setfont.c', 'src/mapscrn.c'})
x('setkeycodes',     '8')
x('setvtrgb',        '8')
x('showconsolefont', '8')
x('showkey',         '1')

-- keymap data
for keymap in iterlines('keymaps.txt') do
	local out = '$outdir/keymaps/'..keymap..'.gz'
	build('gzip', out, '$srcdir/data/keymaps/'..keymap)
	file('share/kbd/keymaps/'..keymap..'.gz', '644', out)
end
sym('share/kbd/keymaps/ppc', 'mac')

fetch 'curl'
