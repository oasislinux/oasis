BEGIN {
	for (n = 0; n < 256; ++n)
		ord[sprintf("%c", n)] = n
}

FNR == 1 {
	print "/* Generated from " FILENAME " */"
}

{
	printf "\""
	s = $0
	while (length(s) > 0) {
		i = match(s, "[^][A-Za-z0-9!#%&'()*+,./:;<=>^_{|}~ -]")
		if (i == 0) {
			printf "%s", s
			break
		}
		printf "%s\\%03o", substr(s, 1, i-1), ord[substr(s, i, 1)]
		s = substr(s, i+1)
	}
	printf "\\012\"\n"
}
