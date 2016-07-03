# usage: awk -f sources.awk sources=sources.txt config.h

$1 == "#define" && $3 ~ /[01]/ {
	cfg[$2] = $3
}

END {
	while (getline < sources) {
		if (NF == 2) {
			var = toupper($2)
			gsub("-", "_", var)
			if (neg = var ~ /^!/)
				var = substr(var, 2)
			if (cfg["HAVE_" var] == neg)
				continue
		}
		print $1
	}
}
