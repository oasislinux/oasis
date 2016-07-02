/^#define/ && $3 {
	cfg[$2] = 1
}

END {
	while (getline < sources) {
		if (!cfg[$1])
			continue
		for (i = 2; i <= NF; ++i) {
			if (match($i, "^" lib "/(" arch "/)?[^/]*$"))
				print substr($i, length(lib) + 2)
		}
	}
}
