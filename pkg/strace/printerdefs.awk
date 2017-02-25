BEGIN {
	FS = "\\(|\\)|, "
	OFS = ", "
}

$1 == "MPERS_PRINTER_DECL" {
	print "." $3 " = " $3 ","
}
