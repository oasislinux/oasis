BEGIN {
	n = 1
	while (getline < readers) {
		if ($0 ~ /^(#|$)/)
			continue
		split($0, r, ":")
		vendor[n] = r[1]
		product[n] = r[2]
		gsub("&", "&amp;", r[3])
		name[n] = r[3]
		++n
	}
}

function printstrs(a) {
	for (i = 1; i < n; ++i)
		printf "\t\t<string>%s</string>\n", a[i]
}

/MAGIC_VENDOR/ {printstrs(vendor); next}
/MAGIC_PRODUCT/ {printstrs(product); next}
/MAGIC_FRIENDLYNAME/ {printstrs(name); next}
/MAGIC_TARGET/ {sub("MAGIC_TARGET", target)}
/MAGIC_VERSION/ {sub("MAGIC_VERSION", version)}
/MAGIC_CLASS/ {
	print "\t<key>CFBundleName</key>"
	print "\t<string>CCIDCLASSDRIVER</string>"
	next
}

{print}
