cflags{
	'-std=c99 -Wall -Wpedantic',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/src', {'gumbo.h', 'tag_enum.h'})

lib('libgumbo.a', [[
	src/(
		attribute.c
		char_ref.c
		error.c
		parser.c
		string_buffer.c
		string_piece.c
		tag.c
		tokenizer.c
		utf8.c
		util.c
		vector.c
	)
]])

fetch 'git'
