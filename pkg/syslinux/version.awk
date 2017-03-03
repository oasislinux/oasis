function def(var, val) {
	printf fmt "\n", var, val
}

{
	def("VERSION", $1)
	def("VERSION_STR", "\"" $1 "\"")

	i = index($1, ".")
	def("VERSION_MAJOR", int(substr($1, 1, i - 1)))
	def("VERSION_MINOR", int(substr($1, i + 1)))

	def("YEAR", $2)
	def("YEAR_STR", "\"" $2 "\"")
}
