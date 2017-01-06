BEGIN {
	blacklist["EV_VERSION"] = 1
	blacklist["BTN_MISC"] = 1
	blacklist["BTN_MOUSE"] = 1
	blacklist["BTN_JOYSTICK"] = 1
	blacklist["BTN_GAMEPAD"] = 1
	blacklist["BTN_DIGI"] = 1
	blacklist["BTN_WHEEL"] = 1
	blacklist["BTN_TRIGGER_HAPPY"] = 1

	prefixes[++numprefixes] = "EV"
	prefixes[++numprefixes] = "REL"
	prefixes[++numprefixes] = "ABS"
	prefixes[++numprefixes] = "KEY"
	prefixes[++numprefixes] = "BTN"
	prefixes[++numprefixes] = "LED"
	prefixes[++numprefixes] = "SND"
	prefixes[++numprefixes] = "MSC"
	prefixes[++numprefixes] = "SW"
	prefixes[++numprefixes] = "FF"
	prefixes[++numprefixes] = "SYN"
	prefixes[++numprefixes] = "REP"
	prefixes[++numprefixes] = "INPUT_PROP"

	names[++numnames] = "abs"
	names[++numnames] = "btn"
	names[++numnames] = "ff"
	names[++numnames] = "key"
	names[++numnames] = "led"
	names[++numnames] = "msc"
	names[++numnames] = "rel"
	names[++numnames] = "rep"
	names[++numnames] = "snd"
	names[++numnames] = "sw"
	names[++numnames] = "syn"

	addbtns["BTN_A"] = 1
	addbtns["BTN_B"] = 1
	addbtns["BTN_X"] = 1
	addbtns["BTN_Y"] = 1
}

function print_bits(prefix) {
	printf "static const char * const %s_map[%s_MAX + 1] = {\n", prefix, toupper(prefix)
	for (j = 1; j <= numbits[prefix]; ++j) {
		split(bits[prefix, j], item, SUBSEP)
		printf "	[%s] = \"%s\",\n", item[1], item[1]
	}
	if (prefix == "key") {
		for (j = 1; j <= numbits["btn"]; ++j) {
			split(bits["btn", j], item, SUBSEP)
			printf "	[%s] = \"%s\",\n", item[1], item[1]
		}
	}
	print "};"
	print ""
}

function print_map() {
	print "static const char * const * const event_type_map[EV_MAX + 1] = {"
	for (i = 1; i <= numprefixes; ++i) {
		prefix = prefixes[i]
		if (prefix == "BTN" || prefix == "EV" || prefix == "INPUT_PROP")
			continue
		printf "	[EV_%s] = %s_map,\n", prefix, tolower(prefix)
	}
	print "};"
	print ""

	print "#if __clang__"
	print "#pragma clang diagnostic push"
	print "#pragma clang diagnostic ignored \"-Winitializer-overrides\""
	print "#else"
	print "#pragma GCC diagnostic push"
	print "#pragma GCC diagnostic ignored \"-Woverride-init\""
	print "#endif"
	print "static const int ev_max[EV_MAX + 1] = {"
	print "	[0 ... EV_MAX] = -1,"
	for (i = 1; i <= numprefixes; ++i) {
		prefix = prefixes[i]
		if (prefix == "BTN" || prefix == "EV" || prefix == "INPUT_PROP")
			continue
		printf "	[EV_%s] = %s_MAX,\n", prefix, prefix
	}
	print "};"
	print "#if __clang__"
	print "#pragma clang diagnostic pop /* \"-Winitializer-overrides\" */"
	print "#else"
	print "#pragma GCC diagnostic pop /* \"-Woverride-init\" */"
	print "#endif"
	print ""
}

function print_lookup(prefix) {
	sort = "sort -t '\"' -k 2"
	for (j = 1; j <= numbits[prefix]; ++j) {
		split(bits[prefix, j], item, SUBSEP)
		printf "	{ .name = \"%s\", .value = %s },\n", item[1], item[1] | sort
	}
	if (prefix == "btn") {
		for (name in addbtns)
			printf "	{ .name = \"%s\", .value = %s },\n", name, name | sort
	}
	close(sort)
}

function print_lookup_table() {
	print "struct name_entry {"
	print "	const char *name;"
	print "	unsigned int value;"
	print "};"
	print ""
	print "static const struct name_entry ev_names[] = {"
	print_lookup("ev")
	print "};"
	print ""

	print "static const struct name_entry code_names[] = {"
	for (i = 1; i <= numnames; ++i)
		print_lookup(names[i])
	print "};"
	print ""
	print "static const struct name_entry prop_names[] = {"
	print_lookup("input_prop")
	print "};"
	print ""
}

function print_mapping_table() {
	print "/* THIS FILE IS GENERATED, DO NOT EDIT */"
	print ""
	print "#ifndef EVENT_NAMES_H"
	print "#define EVENT_NAMES_H"
	print ""

	for (i = 1; i <= numprefixes; ++i) {
		prefix = prefixes[i]
		if (prefix == "BTN")
			continue
		print_bits(tolower(prefix))
	}

	print_map()
	print_lookup_table()

	print "#endif /* EVENT_NAMES_H */"
}

/^#define/ {
	if (blacklist[$2])
		next
	for (i = 1; i <= numprefixes; ++i) {
		prefix = prefixes[i]
		if ($3 !~ /^[0-9a-fx]+$/ || substr($2, 1, length(prefix) + 1) != prefix "_")
			continue
		idx = indexes[prefix, $3]
		if (!idx) {
			idx = ++numbits[tolower(prefix)]
			indexes[prefix, $3] = idx
		}
		bits[tolower(prefix), idx] = $2 SUBSEP $3
	}
}

END {
	print_mapping_table()
}
