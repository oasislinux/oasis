# usage: awk -f gensources.awk src/wscript_build.py >sources.txt

BEGIN {
	FS = "\""
}

/ +\(.*\),$/ {
	if (NF == 3)
		print $2
	else if (NF == 5)
		print $2, $4
}
