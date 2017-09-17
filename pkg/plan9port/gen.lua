set('arch', 'x86_64')

cflags{
	'-D __Linux26__',
	'-D PLAN9PORT',
	'-I $srcdir/include',
	'-I $srcdir/src/cmd/rc',
	'-I $srcdir/src/lib9/fmt',
	'-I $outdir/rc',
}

-- src/src/lib9/mkfile:/^OFILES
lib('lib9.a', [[src/lib9/(
	fmt/(
		dofmt.c
		fltfmt.c
		fmt.c
		fmtfd.c
		fmtfdflush.c
		fmtlocale.c
		fmtnull.c
		fmtprint.c
		fmtquote.c
		fmtrune.c
		fmtstr.c
		fmtvprint.c
		fprint.c
		nan64.c
		print.c
		runefmtstr.c
		runeseprint.c
		runesmprint.c
		runesnprint.c
		runesprint.c
		runevseprint.c
		runevsmprint.c
		runevsnprint.c
		seprint.c
		smprint.c
		snprint.c
		sprint.c
		strtod.c
		vfprint.c
		vseprint.c
		vsmprint.c
		vsnprint.c
		charstod.c
		pow10.c
	)
	fmtlock2.c

	utf/(
		rune.c
		runestrcat.c
		runestrchr.c
		runestrcmp.c
		runestrcpy.c
		runestrdup.c
		runestrlen.c
		runestrecpy.c
		runestrncat.c
		runestrncmp.c
		runestrncpy.c
		runestrrchr.c
		runestrstr.c
		runetype.c
		utfecpy.c
		utflen.c
		utfnlen.c
		utfrrune.c
		utfrune.c
		utfutf.c
	)

	_exits.c
	_p9dialparse.c
	_p9dir.c
	announce.c
	argv0.c
	atexit.c
	atoi.c
	atol.c
	atoll.c
	atnotify.c
	await.c
	cistrcmp.c
	cistrncmp.c
	cistrstr.c
	cleanname.c
	convD2M.c
	convM2D.c
	convM2S.c
	convS2M.c
	create.c
	crypt.c
	ctime.c
	dial.c
	dirfstat.c
	dirfwstat.c
	dirmodefmt.c
	dirread.c
	dirstat.c
	dirwstat.c
	dup.c
	encodefmt.c
	errstr.c
	exec.c
	execl.c
	exitcode.c
	fcallfmt.c
	get9root.c
	getcallerpc-$arch.c
	getenv.c
	getfields.c
	getnetconn.c
	getns.c
	getuser.c
	getwd.c
	jmp.c
	lrand.c
	lnrand.c
	main.c
	malloc.c
	malloctag.c
	mallocz.c
	nan.c
	needsrcquote.c
	needstack.c
	netcrypt.c
	netmkaddr.c
	notify.c
	nrand.c
	nulldir.c
	open.c
	opentemp.c
	pin.c
	pipe.c
	post9p.c
	postnote.c
	qlock.c
	quote.c
	rand.c
	read9pmsg.c
	readcons.c
	readn.c
	rfork.c
	searchpath.c
	seek.c
	sendfd.c
	sleep.c
	strdup.c
	strecpy.c
	sysfatal.c
	syslog.c
	sysname.c
	time.c
	tm2sec.c
	tokenize.c
	truerand.c
	u16.c
	u32.c
	u64.c
	unsharp.c
	wait.c
	waitpid.c
	write.c
	zoneinfo.c
)]])

-- src/src/lib9p/mkfile:/^OFILES
lib('lib9p.a', [[src/lib9p/(
	_post.c
	dirread.c
	fid.c
	file.c
	intmap.c
	mem.c
	req.c
	parse.c
	srv.c
	tpost.c
	uid.c
	util.c
)]])

-- src/src/lib9pclient/mkfile:/^OFILES
lib('lib9pclient.a', [[src/lib9pclient/(
	access.c
	auth.c
	close.c
	create.c
	dirread.c
	fs.c
	ns.c
	open.c
	openfd.c
	print.c
	read.c
	remove.c
	seek.c
	stat.c
	walk.c
	write.c
	wstat.c
)]])

-- src/src/libbio/mkfile:/^OFILES
lib('libbio.a', [[src/libbio/(
	bbuffered.c
	bfildes.c
	bflush.c
	bgetc.c
	bgetrune.c
	bgetd.c
	binit.c
	boffset.c
	bprint.c
	bputc.c
	bputrune.c
	brdline.c
	brdstr.c
	bread.c
	bseek.c
	bvprint.c
	bwrite.c
)]])

-- src/src/libcomplete/mkfile:/^OFILES
lib('libcomplete.a', {'src/libcomplete/complete.c'})

-- src/src/libdraw/mkfile:/^OFILES
lib('libdraw.a', [[src/libdraw/(
	alloc.c
	allocimagemix.c
	arith.c
	bezier.c
	border.c
	buildfont.c
	bytesperline.c
	chan.c
	cloadimage.c
	computil.c
	creadimage.c
	debug.c
	defont.c
	draw.c
	drawclient.c
	drawfcall.c
	drawrepl.c
	egetrect.c
	ellipse.c
	emenuhit.c
	event.c
	font.c
	freesubfont.c
	getdefont.c
	getrect.c
	getsubfont.c
	icossin.c
	icossin2.c
	init.c
	iprint.c
	keyboard.c
	line.c
	loadimage.c
	menuhit.c
	mkfont.c
	mouse.c
	openfont.c
	poly.c
	readimage.c
	readsubfont.c
	rectclip.c
	replclipr.c
	rgb.c
	scroll.c
	snarf.c
	string.c
	stringbg.c
	stringsubfont.c
	stringwidth.c
	subfont.c
	subfontcache.c
	subfontname.c
	unloadimage.c
	window.c
	writeimage.c
	writesubfont.c
	wsys.c
	unix.c
)]])

-- src/src/libframe/mkfile:/^OFILES
lib('libframe.a', [[src/libframe/(
	frbox.c
	frdelete.c
	frdraw.c
	frinit.c
	frinsert.c
	frptofchar.c
	frselect.c
	frstr.c
	frutil.c
)]])

-- src/src/libmemdraw/mkfile:/^OFILES
lib('libmemdraw.a', [[src/libmemdraw/(
	alloc.c
	alloc-stub.c
	arc.c
	cload.c
	cload-stub.c
	cmap.c
	cread.c
	defont.c
	draw.c
	draw-stub.c
	ellipse.c
	fillpoly.c
	hwdraw.c
	iprint.c
	line.c
	load.c
	load-stub.c
	openmemsubfont.c
	poly.c
	read.c
	string.c
	subfont.c
	unload.c
	unload-stub.c
	write.c
)]])

-- src/src/libmemlayer/mkfile:/^OFILES
lib('libmemlayer.a', [[src/libmemlayer/(
	draw.c
	lalloc.c
	layerop.c
	ldelete.c
	lhide.c
	line.c
	load.c
	lorigin.c
	lsetrefresh.c
	ltofront.c
	ltorear.c
	unload.c
)]])

-- src/src/libmux/mkfile:/^OFILES
lib('libmux.a', 'src/libmux/(io.c mux.c queue.c thread.c)')

-- src/src/libplumb/mkfile:/^OFILES
lib('libplumb.a', 'src/libplumb/(event.c fid.c mesg.c)')

-- src/src/cmd/rc/mkfile:/^OFILES
yacc('rc/x', '$srcdir/src/cmd/rc/syn.y')
-- remove stdlib.h and string.h includes so that u.h comes first.
build('grep', '$outdir/rc/syn.c', '$outdir/rc/x.tab.c', {
	expr=[[-F -x -v -e '#include <stdlib.h>' -e '#include <string.h>']],
})
exe('bin/rc', [[$outdir/rc/syn.c src/cmd/rc/(
	code.c
	exec.c
	getflags.c
	glob.c
	havefork.c
	here.c
	io.c
	lex.c
	pcmd.c
	pfnc.c
	plan9ish.c
	simple.c
	subr.c
	trap.c
	tree.c
	unixcrap.c
	var.c
) lib9.a]], {'$outdir/rc/x.tab.h'})
file('bin/rc', '755', '$outdir/bin/rc')
file('lib/rcmain', '644', '$srcdir/rcmain')

-- src/src/cmd/sam/mkfile:/^OFILES
exe('bin/sam', [[src/cmd/sam/(
	sam.c
	address.c
	buff.c
	cmd.c
	disk.c
	error.c
	file.c
	io.c
	list.c
	mesg.c
	moveto.c
	multi.c
	rasp.c
	regexp.c
	shell.c
	string.c
	sys.c
	unix.c
	util.c
	xec.c
) libplumb.a lib9.a]])
file('bin/sam', '755', '$outdir/bin/sam')

man{'man/man1/rc.1', 'man/man1/sam.1'}

fetch 'git'
