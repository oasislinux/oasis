BEGIN {
	print "enum {"
	print "SEN_printargs = 0,"
}

match($0, /SEN\([^)]+\)/) {
	name = substr($0, RSTART + 4, RLENGTH - 5)
	if (name != "printargs")
		print "SEN_" name "," | "sort -u"
}

END {
	if (close("sort -u"))
		exit 1
	print "};"
}
