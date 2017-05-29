BEGIN {
	FS = "\\[[[:space:]]*|[]\"]"
}

{
	name = $4
	number = $2
	print "#ifndef __NR_" name
	print "# define __NR_" name " (SYSCALL_BIT | " number ")"
	print "#endif"
}
