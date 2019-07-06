static char target[]         = "x86_64-linux-musl";
static char *startfiles[]    = {"-l", ":crt1.o", "-l", ":crti.o"};
static char *endfiles[]      = {"-l", "c", "-l", ":crtn.o"};
static char *preprocesscmd[] = {
	"cpp", "-P",

	/* clear preprocessor GNU C version */
	"-U", "__GNUC__",
	"-U", "__GNUC_MINOR__",

	/* we don't yet support these optional features */
	"-D", "__STDC_NO_ATOMICS__",
	"-D", "__STDC_NO_COMPLEX__",
	"-D", "__STDC_NO_VLA__",
	"-U", "__SIZEOF_INT128__",

	/* ignore attributes and extension markers */
	"-D", "__attribute__(x)=",
	"-D", "__extension__=",
};
static char *codegencmd[]    = {"qbe"};
static char *assemblecmd[]   = {"as"};
static char *linkcmd[]       = {"ld", "--dynamic-linker", "/lib/ld-musl-x86_64.so.1"};
