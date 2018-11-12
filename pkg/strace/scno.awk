BEGIN {
	FS = "[][\"]"
}

{
	name = $4
	number = int($2)
	print "#ifndef __NR_" name
	print "# define __NR_" name " (SYSCALL_BIT | " number ")"
	print "#endif"
}
