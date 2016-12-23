BEGIN {
	for (i = 32; i <= 126; ++i)
		ord[sprintf("%c", i)] = i
	n = -1
}

function makenode(c) {
	++n
	splits[n] = c
	left[n] = -1
	equal[n] = -1
	right[n] = -1
	values[n] = 0
}

function insert(nodes, id, c) {
	nextid = nodes[id]
	if (nextid != -1)
		return nextid
	makenode(c)
	nodes[id] = n
	return n
}

/^(#|$)/ {next}

{
	id = 0
	c = ord[substr($1, 1, 1)]
	if (n < 0)
		makenode(c)
	for (i = 1; i <= length($1) + 1;) {
		if (c < splits[id]) {
			id = insert(left, id, c)
		} else if (c == splits[id]) {
			if (i >= length($1))
				values[id] = $2
			if (c == 0)
				break
			++i
			c = i <= length($1) ? ord[substr($1, i, 1)] : 0
			id = insert(equal, id, c)
		} else {
			id = insert(right, id, c)
		}
	}
}

END {
	print "static hubbub_entity_node dict[] = {"
	for (i = 0; i <= n; ++i)
		print "\t{ "splits[i]", "left[i]", "equal[i]", "right[i]", "values[i]" },"
	print "};"
	print "static int32_t dict_root = 0;"
}
