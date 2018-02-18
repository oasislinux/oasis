BEGIN {
	dirs["$(base)"] = "ncurses/base"
	dirs["$(serial)"] = "ncurses/tty"
	dirs["$(trace)"] = "ncurses/trace"
	dirs["$(tinfo)"] = "ncurses/tinfo"
	dirs["$(wide)"] = "ncurses/widechar"
	dirs["$(win32con)"] = "ncurses/win32con"
	dirs["."] = "$outdir"

	skip["expanded"] = 1
	skip["lib_gen"] = 1
	skip["link_test"] = 1

	print "return {"
}

/^(#|$)/ { next }

/^@/ {
	if (open)
		print "\t},"
	else
		open = 1
	print "\t" $2 "={"
	next
}

{
	if ($1 in skip)
		next
	print "\t\t'" dirs[$3] "/" $1 ".c',"
}

END {
	if (open)
		print "\t},"
	print "}"
}
