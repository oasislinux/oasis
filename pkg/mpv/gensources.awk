# usage: awk -f gensources.awk src/wscript_build.py >sources.txt

BEGIN {
	FS = "\""
	ignore["osdep/terminal-dummy.c"] = 1
	ignore["input/ipc-dummy.c"] = 1
	ignore["osdep/subprocess-dummy.c"] = 1
}

/ +\(.*\),$/ {
	if (ignore[$2])
		next
	if (NF == 3)
		print $2
	else if (NF == 5)
		print $2, $4
}
