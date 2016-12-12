$0 == "*static*" {static = 1; next}
$0 == "*shared*" {static = 0; next}

NF && !/^#/ && static {
	for (i = 2; i <= NF; ++i)
		print $i
}
