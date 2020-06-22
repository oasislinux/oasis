BEGIN {
	RS = ""
	sort = "sort -k 2"
}

function mode() {
	for (i = 2; i <= NF; ++i) {
		if ($i ~ /^mode=/)
			return substr($i, 6)
	}
	printf "file '%s' is missing mode attribute\n", $1 >"/proc/self/fd/2"
	exit(1)
}

/type=dir/ {
	printf "04%s %s\n", mode(), substr($1, 2) |sort
}

/type=reg/ {
	m = mode()
	if (m != "0644" && m != "0755")
		printf "10%s %s\n", m, substr($1, 2) |sort
}
