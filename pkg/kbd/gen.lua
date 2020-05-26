cflags{
	string.format([[-D 'DATADIR="%s/share/kbd"']], config.prefix),
	'-I $dir',
	'-I $srcdir',
	'-I $srcdir/src',
	'-I $srcdir/src/libcommon',
	'-I $srcdir/src/libkbdfile',
	'-I $srcdir/src/libkeymap',
	'-I $srcdir/src/libkeymap/keymap',
	'-I $builddir/pkg/linux-headers/include',
}

pkg.deps = {
	'pkg/linux-headers/headers',
}

lib('libcommon.a', 'src/libcommon/(getfd.c error.c version.c xmalloc.c)')
lib('libkbdfile.a', 'src/libkbdfile/(init.c kbdfile.c)')
lib('libkeymap.a', [[src/libkeymap/(
	analyze.c
	array.c
	common.c
	diacr.c
	dump.c
	func.c
	kernel.c
	kmap.c
	ksyms.c
	loadkeys.c
	modifiers.c
	parser.c
	summary.c
)]])
lib('libfont.a', 'src/(kdfontop.c kdmapop.c loadunimap.c psffontop.c utf8.c)')

-- old: loadunimap mapscrn
-- optional: clrunmap getunimap setlogcons setvesablank setpalette screendump
-- i386/x86_64 only: resizecons
-- ubase: chvt

local tools = {
	{'deallocvt',       '1'},
	{'dumpkeys',        '1', true},
	{'fgconsole',       '1'},
	{'getkeycodes',     '8'},
	{'kbd_mode',        '1'},
	{'kbdinfo'},
	{'loadkeys',        '1', true},
	{'openvt',          '1'},
	{'psfxtable',       '1'},
	{'setfont',         '8', true, {'src/setfont.c', 'src/mapscrn.c'}},
	{'setkeycodes',     '8'},
	{'setvtrgb',        '8'},
	{'showconsolefont', '8'},
	{'showkey',         '1'},
}

for _, tool in ipairs(tools) do
	local name, sect, subst, srcs = tool[1], tool[2], tool[3], tool[4]
	exe(name, {srcs or 'src/'..name..'.c', 'libcommon.a', 'libfont.a', 'libkeymap.a', 'libkbdfile.a'})
	file('bin/'..name, '755', '$outdir/'..name)
	if sect then
		local manpage = string.format('docs/man/man%s/%s.%s', sect, name, sect)
		if subst then
			local out = string.format('$outdir/%s.%s', name, sect)
			build('sed', out, '$srcdir/'..manpage..'.in', {
				expr='s,@DATADIR@,/share/kbd,g',
			})
			manpage = out
		end
		man{manpage}
	end
end

-- keymap data
for keymap in iterlines('keymaps.txt') do
	local out = '$outdir/keymaps/'..keymap..'.gz'
	build('gzip', out, '$srcdir/data/keymaps/'..keymap)
	file('share/kbd/keymaps/'..keymap..'.gz', '644', out)
end
sym('share/kbd/keymaps/ppc', 'mac')

fetch 'curl'
