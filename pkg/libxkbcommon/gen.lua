cflags{
	'-include $dir/config.h',
	'-I $srcdir',
	'-I $srcdir/src',
}

lib('libxkbcommon.a', [[src/(
	compose/parser.c
	compose/paths.c
	compose/state.c
	compose/table.c
	xkbcomp/action.c
	xkbcomp/ast-build.c
	xkbcomp/compat.c
	xkbcomp/expr.c
	xkbcomp/include.c
	xkbcomp/keycodes.c
	xkbcomp/keymap.c
	xkbcomp/keymap-dump.c
	xkbcomp/keywords.c
	xkbcomp/parser.c
	xkbcomp/rules.c
	xkbcomp/scanner.c
	xkbcomp/symbols.c
	xkbcomp/types.c
	xkbcomp/vmod.c
	xkbcomp/xkbcomp.c
	atom.c
	context.c
	context-priv.c
	keysym.c
	keysym-utf.c
	keymap.c
	keymap-priv.c
	state.c
	text.c
	utf8.c
	utils.c
)]])

fetch 'curl'
