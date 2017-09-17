cflags{
	'-I $srcdir/include',
	'-I $srcdir/src',
}

build('awk', '$outdir/aliases.inc', {'$srcdir/build/Aliases', '|', '$dir/aliases.awk'}, {
	expr='-f $dir/aliases.awk',
})

cc('src/charset/aliases.c', {'$outdir/aliases.inc'}, {cflags='$cflags -I $outdir'})
lib('libparserutils.a', [[src/(
	charset/(
		aliases.c.o codec.c
		encodings/(utf8.c utf16.c)
	)
	input/(filter.c inputstream.c)
	utils/(buffer.c errors.c stack.c vector.c)
)]])

fetch 'git'
