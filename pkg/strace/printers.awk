BEGIN {
	FS = "\\(|\\)|, "
	OFS = ", "
	print "typedef struct {"
}

$1 == "MPERS_PRINTER_DECL" {
	printf " %s (*%s)(%s", $2, $3, $4
	for (i = 5; i < NF; ++i)
		printf ", %s", $i
	print ");"
	print "#define " $3 " MPERS_PRINTER_NAME(" $3 ")\n"
}

END {
	print "} struct_printers;"
	print "extern const struct_printers *printers;"
	print "#define MPERS_PRINTER_NAME(printer_name) printers->printer_name"
}
