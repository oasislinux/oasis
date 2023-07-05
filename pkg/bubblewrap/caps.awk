BEGIN {
	print "static const char *const cap_names[] = {"
}
/^#define CAP_[^[:space:]]+[[:space:]]+[0-9]+[[:space:]]*$/ {
	printf "\t[%d] = \"%s\",\n", $3, tolower($2)
}
END {
	print "};"
}
