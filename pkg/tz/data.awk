BEGIN { print "return {" }

FNR == 1 {
	if (n)
		print "\t},"
	n = split(FILENAME, src, "/")
	printf "\t%s={\n", src[n]
}

$1 == "Link" { printf "\t\t[\"%s\"]=\"%s\",\n", $3, $2 }
$1 == "Zone" { printf "\t\t[\"%s\"]=false,\n", $2 }

END {
	if (n)
		print "\t},"
	print "}"
}
