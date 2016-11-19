BEGIN {
	dirs["$(base)"] = "ncurses/base"
	dirs["$(serial)"] = "ncurses/tty"
	dirs["$(trace)"] = "ncurses/trace"
	dirs["$(tinfo)"] = "ncurses/tinfo"
	dirs["$(wide)"] = "ncurses/widechar"
	dirs["."] = "$outdir"

	skip["codes"] = 1
	skip["expanded"] = 1
	skip["lib_gen"] = 1
	skip["link_test"] = 1

	split(subsets, a, "+")
	for (k in a)
		sets[a[k]] = 1
}

/^(#|$)/ { next }

/^@/ {
	set = $2
	next
}

set in sets {
	if ($1 ~ /trace/ || $1 in skip)
		next
	print dirs[$3] "/" $1 ".c"
}
