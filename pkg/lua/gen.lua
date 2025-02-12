cflags{
	'-std=c99', '-Wall', '-Wextra', '-Wpedantic', '-Wno-implicit-fallthrough',
	'-D _DEFAULT_SOURCE',
	'-D LUA_USE_POSIX',
	'-D LUA_USE_JUMPTABLE=0',
}

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/src', {'lua.h', 'luaconf.h', 'lualib.h', 'lauxlib.h'}),
	install=true,
}

lib('liblua.a', [[src/(
	lapi.c lcode.c lctype.c ldebug.c ldo.c ldump.c lfunc.c lgc.c llex.c
	lmem.c lobject.c lopcodes.c lparser.c lstate.c lstring.c ltable.c
	ltm.c lundump.c lvm.c lzio.c
	lauxlib.c lbaselib.c lcorolib.c ldblib.c liolib.c lmathlib.c
	loslib.c lstrlib.c ltablib.c lutf8lib.c loadlib.c linit.c
)]])
file('lib/liblua.a', '644', '$outdir/liblua.a')

exe('lua', {'src/lua.c', 'liblua.a', '$builddir/pkg/luaposix/libluaposix.a'})
file('bin/lua5.4', '755', '$outdir/lua')
sym('bin/lua', 'lua5.4')
exe('luac', {'src/luac.c', 'liblua.a'})
file('bin/luac5.4', '755', '$outdir/luac')
sym('bin/luac', 'luac5.4')

man{'doc/lua.1', 'doc/luac.1'}

fetch 'curl'
