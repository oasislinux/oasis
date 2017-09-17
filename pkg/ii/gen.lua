set('version', '1.7-13-g704ab92')
cflags{
	'-Wall',
	[[-D 'VERSION="$version"']],
}

exe('ii', {'ii.c'})
file('bin/ii', '755', '$outdir/ii')

build('sed', '$outdir/ii.1', '$srcdir/ii.1', {expr='s,VERSION,$version,'})
man{'$outdir/ii.1'}

fetch 'git'
