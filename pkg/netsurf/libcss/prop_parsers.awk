BEGIN {
	FS=":"
}

/^#/ { next }
/^$/ { next }

{
	system(gen_prop_parser " '" $0 "'")
}
