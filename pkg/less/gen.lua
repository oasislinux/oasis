cflags{
	'-I $dir',
	'-isystem $builddir/pkg/netbsd-curses/include',
}

objects[[
	lesskey_parse.c
	version.c
	xbuf.c
]]

exe('less', [[
	main.c screen.c brac.c ch.c charset.c cmdbuf.c
	command.c cvt.c decode.c edit.c filename.c forwback.c
	help.c ifile.c input.c jump.c
	line.c linenum.c
	lsystem.c mark.c optfunc.c option.c opttbl.c os.c
	output.c pattern.c position.c prompt.c search.c signal.c
	tags.c ttyin.c version.c.o xbuf.c.o
	lesskey_parse.c.o
	$builddir/pkg/netbsd-curses/libcurses.a.d
]], {'pkg/netbsd-curses/headers'})
file('bin/less', '755', '$outdir/less')

exe('lessecho', {'lessecho.c', 'version.c.o'})
file('bin/lessecho', '755', '$outdir/lessecho')

exe('lesskey', {'lesskey.c', 'lesskey_parse.c.o', 'xbuf.c.o', 'version.c.o'})
file('bin/lesskey', '755', '$outdir/lesskey')

man({'less.nro', 'lessecho.nro', 'lesskey.nro'}, '1')

sym('bin/more', 'less')

fetch 'curl'
