BEGIN {
	FS = "\\(|\\)|, "
	OFS = ", "
}

$1 == "MPERS_PRINTER_DECL" {
	printf "extern %s %s(%s", $2, $3, $4
	for (i = 5; i < NF; ++i)
		printf ", %s", $i
	print ");"
}
