cflags{
	'-std=c99 -Wall -Wextra -pedantic',
	'-D _BSD_SOURCE',
	'-D _POSIX_C_SOURCE=200809L',
}

exe('crond', {'crond.c'})
file('bin/crond', '755', '$outdir/crond')
man{'scron.1'}

fetch 'git'
