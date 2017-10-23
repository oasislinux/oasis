toolchain 'host'
cflags{'-I $srcdir/src'}

local generated = {
	'nsgenbind-lexer.c',
	'nsgenbind-parser.c',
	'webidl-lexer.c',
	'webidl-parser.c',
}
for _, src in ipairs(generated) do
	build('cc', '$outdir/src/'..src..'.o', {'$dir/'..src, '||', '$dir/fetch'})
end

exe('nsgenbind', [[src/(
	nsgenbind.c utils.c webidl-ast.c nsgenbind-ast.c ir.c
	duk-libdom.c duk-libdom-interface.c duk-libdom-dictionary.c
	duk-libdom-common.c duk-libdom-generated.c

	nsgenbind-lexer.c.o nsgenbind-parser.c.o
	webidl-lexer.c.o webidl-parser.c.o
)]])

fetch 'git'
