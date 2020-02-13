BEGIN {
	guard = toupper("_ASM_" arch "_" file)
	gsub(/[^A-Za-z0-9_]/, "_", guard)
	print "#ifndef " guard
	print "#define " guard " 1"
	print ""
}

$0 ~ /^[^#]+/ && $2 ~ "^(" abi ")$" {
	if (off != "")
		$1 = "(" off " + " $1 ")"
	print "#define __NR_" $3, $1
}

END {
	print ""
	print "#endif /* " guard " */"
}
