return {
	-- <cd src/arch/riscv/include/uapi && find * -name '*.h' -exec printf "\t'%s',\n" {} + | LC_COLLATE=C sort
	'asm/auxvec.h',
	'asm/bitsperlong.h',
	'asm/bpf_perf_event.h',
	'asm/byteorder.h',
	'asm/elf.h',
	'asm/hwcap.h',
	'asm/hwprobe.h',
	'asm/kvm.h',
	'asm/perf_regs.h',
	'asm/ptrace.h',
	'asm/setup.h',
	'asm/sigcontext.h',
	'asm/ucontext.h',
	'asm/unistd.h',
	'asm/vendor/mips.h',
	'asm/vendor/sifive.h',
	'asm/vendor/thead.h',
	unistd = {},
	generic={
		-- <awk '$1 == "generic-y" {printf "\\t\\t'\'%s\'',\\n", $3}' src/arch/riscv/include/uapi/asm/Kbuild
		'kvm_para.h',
	},		
}
