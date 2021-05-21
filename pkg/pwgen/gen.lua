cflags{
	'-std=c99 -Wall -Wpedantic',
	'-D _POSIX_C_SOURCE=200809L',
}

exe('pwgen', {
	'pwgen.c',
	'pw_phonemes.c',
	'pw_rand.c',
	'randnum.c',
	'sha1.c',
	'sha1num.c',
})
file('bin/pwgen', '755', '$outdir/pwgen')
man{'pwgen.1'}

fetch 'git'
