cflags{
	'-std=c99', '-Wall', '-Wextra', '-Wpedantic',
	'-Wno-format-overflow', '-Wno-format-truncation', '-Wno-maybe-uninitialized',
	'-I $dir',
}

exe('qbe', [[
	main.c util.c parse.c abi.c cfg.c mem.c ssa.c alias.c load.c
	copy.c fold.c simpl.c live.c spill.c rega.c emit.c
	amd64/(targ.c sysv.c isel.c emit.c)
	arm64/(targ.c abi.c isel.c emit.c)
	rv64/(targ.c abi.c isel.c emit.c)
]])
file('bin/qbe', '755', '$outdir/qbe')

fetch 'git'
