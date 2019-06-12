cflags{'-Wall', '-Winline'}

lib('libbz2.a', {
	'blocksort.c',
	'huffman.c',
	'crctable.c',
	'randtable.c',
	'compress.c',
	'decompress.c',
	'bzlib.c'
})
exe('bzip2', {'bzip2.c', 'libbz2.a'})

file('bin/bzip2', '755', '$outdir/bzip2')
man{'man/bzip2.1'}
sym('bin/bzcat', 'bzip2')

fetch 'git'
