/^(#|$)/ { next }
{
	enabled[$0] = 1
}

END {
	while (getline < sources) {
		if (!enabled[$1])
			continue
		for (i = 2; i <= NF; ++i)
			print $i
	}
}
