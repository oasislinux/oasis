BEGIN {
}
/^(#|$)/ {next}
{
	i = index($0, ":")
	if (!i)
		next
	split(substr($0, 1, i - 1), key, ".")
	if (lang == key[1] && (filter == "any" || key[2] == "all" || key[3] == filter))
		print key[3] substr($0, i)
}
