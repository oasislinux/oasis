cflags{
	'-I $dir',
	'-isystem $builddir/pkg/ncurses/include',
}

cc('version.c')

exe('less', [[
	main.c screen.c brac.c ch.c charset.c cmdbuf.c
	command.c cvt.c decode.c edit.c filename.c forwback.c
	help.c ifile.c input.c jump.c line.c linenum.c
	lsystem.c mark.c optfunc.c option.c opttbl.c os.c
	output.c pattern.c position.c prompt.c search.c signal.c
	tags.c ttyin.c version.c.o
	$builddir/pkg/ncurses/libncurses.a
]], {'pkg/ncurses/headers'})
file('bin/less', '755', '$outdir/less')

exe('lessecho', {'lessecho.c', 'version.c.o'})
file('bin/lessecho', '755', '$outdir/lessecho')

exe('lesskey', {'lesskey.c', 'version.c.o'})
file('bin/lesskey', '755', '$outdir/lesskey')

for _, cmd in ipairs{'less', 'lessecho', 'lesskey'} do
	build('gzip', '$outdir/'..cmd..'.1.gz', '$srcdir/'..cmd..'.nro')
	file('share/man/man1/'..cmd..'.1.gz', '644', '$outdir/'..cmd..'.1.gz')
end

sym('bin/more', 'less')

fetch 'curl'
