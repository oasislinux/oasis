BEGIN {
	print "static parserutils_charset_aliases_canon canonical_charset_names[] = {"
	n = 0
}

/^(#|$)/ {next}

function addalias(s) {
	s = tolower(s)
	gsub("[^a-z0-9]", "", s)
	if (!(s in aliases))
		++num_aliases
	aliases[s] = n
}


{
	print "\t{ "$2", "length($1)", \""$1"\" },"
	addalias($1)
	for (i = 3; i <= NF; ++i)
		addalias($i)
	if ($1 ~ /^ISO-10646-UCS-[24]$/ || $1 ~ /^UTF-(8$|16|32)/)
		isunicode = (isunicode ? (isunicode" || ") : "") "((x) == "$2")"
	++n
}
END {
	print "};"

	print "static const uint16_t charset_aliases_canon_count = "n";"

	print "typedef struct {"
	print "\tuint16_t name_len;"
	print "\tconst char *name;"
	print "\tparserutils_charset_aliases_canon *canon;"
	print "} parserutils_charset_aliases_alias;"

	print "static parserutils_charset_aliases_alias charset_aliases[] = {"
	for (alias in aliases) {
		i = aliases[alias]
		print "\t{ "length(alias)", \""alias"\", &canonical_charset_names["i"] }," | "sort -t '\"' -k 2"
	}
	close("sort -t '\"' -k 2")
	print "};"
	print "static const uint16_t charset_aliases_count = "num_aliases";"
	print "#define MIBENUM_IS_UNICODE(x) ("isunicode")"
}
