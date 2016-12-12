{
	d = 0
	for (i = 1; i <= length($0); ++i)
		d = d * 16 + index("0123456789ABCDEF", substr($0, i, 1)) - 1
	unimap[unimap_len++] = d
}

function readchar() {
	name = $2
	buf = ""
	while (getline < font) {
		if ($1 == "ENDCHAR")
			break
		if ($1 == "ENCODING")
			encoding = $2
		else
			buf = buf $0 "\n"
	}
	names[encoding] = name
	chars[encoding] = buf
}

function printchar(i, encoding) {
	if (!(encoding in names))
		exit(1)
	print "STARTCHAR", names[encoding]
	print "ENCODING", i
	printf "%s", chars[encoding]
	print "ENDCHAR"
}

END {
	while (getline < font) {
		if ($1 == "STARTCHAR") {
			readchar()
			break
		}
		if ($1 == "CHARS")
			$2 = unimap_len
		else if ($1 == "FONT")
			sub(/-[^-]*-[^-]*$/, "-" charset, $2)
		print
	}
	while (getline < font) {
		if ($1 == "STARTCHAR")
			readchar()
		else
			tail = tail $0 "\n"
	}
	for (i = 0; i < unimap_len; ++i) {
		encoding = unimap[i]
		printchar(i >= 32 ? encoding : i, encoding)
	}
	printf "%s", tail
}
