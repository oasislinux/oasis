BEGIN {
	duplicates["EV_VERSION"] = 1
	duplicates["BTN_MISC"] = 1
	duplicates["BTN_MOUSE"] = 1
	duplicates["BTN_JOYSTICK"] = 1
	duplicates["BTN_GAMEPAD"] = 1
	duplicates["BTN_DIGI"] = 1
	duplicates["BTN_WHEEL"] = 1
	duplicates["BTN_TRIGGER_HAPPY"] = 1
	duplicates["SW_MAX"] = 1
	duplicates["REP_MAX"] = 1

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
	prefixes[++numprefixes] = "MT_TOOL"

	code_prefixes[++numcode_prefixes] = "ABS"
	code_prefixes[++numcode_prefixes] = "BTN"
	code_prefixes[++numcode_prefixes] = "FF"
	code_prefixes[++numcode_prefixes] = "KEY"
	code_prefixes[++numcode_prefixes] = "LED"
	code_prefixes[++numcode_prefixes] = "MSC"
	code_prefixes[++numcode_prefixes] = "REL"
	code_prefixes[++numcode_prefixes] = "REP"
	code_prefixes[++numcode_prefixes] = "SND"
	code_prefixes[++numcode_prefixes] = "SW"
	code_prefixes[++numcode_prefixes] = "SYN"

	addbtns["BTN_A"] = 1
	addbtns["BTN_B"] = 1
	addbtns["BTN_X"] = 1
	addbtns["BTN_Y"] = 1

	skip["BTN"] = 1
	skip["EV"] = 1
	skip["INPUT_PROP"] = 1
	skip["MT_TOOL"] = 1
}

function print_bits(prefix) {
	printf "static const char * const %s_map[%s_MAX + 1] = {\n", tolower(prefix), prefix
	for (j = 1; j <= numbits[prefix]; ++j) {
		name = bits[prefix, j]
		printf "	[%s] = \"%s\",\n", name, name
	}
	if (prefix == "KEY") {
		for (j = 1; j <= numbits["BTN"]; ++j) {
			name = bits["BTN", j]
			printf "	[%s] = \"%s\",\n", name, name
		}
	}
	print "};"
	print ""
}

function print_map() {
	print "static const char * const * const event_type_map[EV_MAX + 1] = {"
	for (i = 1; i <= numprefixes; ++i) {
		prefix = prefixes[i]
		if (prefix in skip)
			continue
		printf "	[EV_%s] = %s_map,\n", prefix, tolower(prefix)
	}
	print "};"
	print ""

	print "#if __clang__"
	print "#pragma clang diagnostic push"
	print "#pragma clang diagnostic ignored \"-Winitializer-overrides\""
	print "#elif __GNUC__"
	print "#pragma GCC diagnostic push"
	print "#pragma GCC diagnostic ignored \"-Woverride-init\""
	print "#endif"
	print "static const int ev_max[EV_MAX + 1] = {"
	for (i = 1; i <= numprefixes; ++i) {
		prefix = prefixes[i]
		if (prefix in skip)
			continue
		printf "	[EV_%s] = %s_MAX,\n", prefix, prefix
	}
	print "};"
	print "#if __clang__"
	print "#pragma clang diagnostic pop /* \"-Winitializer-overrides\" */"
	print "#elif __GNUC__"
	print "#pragma GCC diagnostic pop /* \"-Woverride-init\" */"
	print "#endif"
	print ""
}

function print_lookup_entry(name, sort) {
	printf "	{ .name = \"%s\", .value = %s },\n", name, name | sort
}

function print_lookup(prefix) {
	sort = "sort -t '\"' -k 2"
	for (j = 1; j <= numbits[prefix]; ++j)
		print_lookup_entry(bits[prefix, j], sort)
	if (prefix == "BTN") {
		for (name in addbtns)
			print_lookup_entry(name, sort)
	}
	maxname = prefix "_MAX"
	if (maxname in duplicates)
		print_lookup_entry(maxname, sort)
	close(sort)
}

function print_lookup_table() {
	print "struct name_entry {"
	print "	const char *name;"
	print "	unsigned int value;"
	print "};"
	print ""
	print "static const struct name_entry tool_type_names[] = {"
	print_lookup("MT_TOOL")
	print "};"
	print ""
	print "static const struct name_entry ev_names[] = {"
	print_lookup("EV")
	print "};"
	print ""

	print "static const struct name_entry code_names[] = {"
	for (i = 1; i <= numcode_prefixes; ++i)
		print_lookup(code_prefixes[i])
	print "};"
	print ""
	print "static const struct name_entry prop_names[] = {"
	print_lookup("INPUT_PROP")
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
		print_bits(prefix)
	}

	print_map()
	print_lookup_table()

	print "#endif /* EVENT_NAMES_H */"
}

/^#define/ {
	for (i = 1; i <= numprefixes; ++i) {
		prefix = prefixes[i]
		if ($3 !~ /^[0-9a-fx]+$/ || substr($2, 1, length(prefix) + 1) != prefix "_")
			continue
		if ($2 in duplicates)
			next
		idx = indexes[prefix, $3]
		if (!idx) {
			idx = ++numbits[prefix]
			indexes[prefix, $3] = idx
		}
		bits[prefix, idx] = $2
	}
}

END {
	print_mapping_table()
}
