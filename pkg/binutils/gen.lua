local version = setmetatable({2, 38}, {__index=function() return 0 end})
local defvec = 'x86_64_elf64_vec'
local selvecs = {[defvec]=true, i386_elf32_vec=true}
local selarchs = {i386=true}
local emuls = {
	'elf_x86_64',
	'elf_i386',
}

cflags{
	'-std=c99', '-Wall', '-Wno-return-local-addr', '-Wno-stringop-truncation',
	'-D _POSIX_C_SOURCE=200809L',
	'-D HAVE_CONFIG_H',
	'-I $srcdir/include',
	'-I $outdir/bfd',
	'-I $srcdir/bfd',
	'-isystem $builddir/pkg/zlib/include',
}

pkg.deps = {
	'pkg/zlib/headers',
	'$outdir/bfd/bfd.h',
	'$outdir/bfd/bfd_stdint.h',
}

sub('libiberty.ninja', function()
	cflags{'-I $dir/libiberty'}
	-- src/libiberty/Makefile.in:/^REQUIRED_OFILES
	lib('libiberty.a', [[libiberty/(
		regex.c cplus-dem.c cp-demangle.c
		md5.c sha1.c alloca.c
		argv.c
		choose-temp.c concat.c
		cp-demint.c crc32.c d-demangle.c
		dwarfnames.c dyn-string.c
		fdmatch.c fibheap.c
		filedescriptor.c
		filename_cmp.c floatformat.c
		fnmatch.c fopen_unlocked.c
		getopt.c getopt1.c getpwd.c
		getruntime.c hashtab.c hex.c
		lbasename.c lrealpath.c
		make-relative-prefix.c make-temp-file.c
		objalloc.c
		obstack.c
		partition.c pexecute.c physmem.c
		pex-common.c pex-one.c
		pex-unix.c vprintf-support.c
		rust-demangle.c
		safe-ctype.c
		simple-object.c simple-object-coff.c
		simple-object-elf.c simple-object-mach-o.c
		simple-object-xcoff.c
		sort.c spaces.c
		splay-tree.c stack-limit.c
		strerror.c strsignal.c
		timeval-utils.c unlink-if-ordinary.c
		xasprintf.c xatexit.c xexit.c
		xmalloc.c xmemdup.c xstrdup.c
		xstrerror.c xstrndup.c
		xvasprintf.c
	)]])
end)

sub('bfd.ninja', function()
	cflags{'-I $dir/bfd'}
	build('sed', '$outdir/bfd/bfd.h', '$srcdir/bfd/bfd-in2.h', {expr={
		'-e s,@supports_plugins@,0,',
		'-e s,@wordsize@,64,',
		'-e s,@bfd_default_target_size@,64,',
		'-e s,@BFD_HOST_64BIT_LONG@,1,',
		'-e s,@BFD_HOST_64BIT_LONG_LONG@,1,',
		'-e s,@BFD_HOST_64_BIT_DEFINED@,1,',
		'-e s,@BFD_HOST_64_BIT@,long,',
		[[-e 's,@BFD_HOST_U_64_BIT@,unsigned long,']],
		[[-e 's,@BFD_HOSTPTR_T@,unsigned long,']],
		'-e s,@bfd_file_ptr@,BFD_HOST_64_BIT,',
	}})
	build('sed', '$outdir/bfd/bfdver.h', '$srcdir/bfd/version.h', {expr={
		string.format('-e s,@bfd_version@,%d%02d%02d%02d%02d,', version[1], version[2], version[3], version[4], version[5]),
		string.format([[-e 's,@bfd_version_string@,"%s",']], table.concat(version, '.')),
		[[-e 's,@bfd_version_package@,"(GNU Binutils) ",']],
		[[-e 's,@report_bugs_to@,"<http://www.sourceware.org/bugzilla/>",']],
	}})
	build('printf', '$outdir/bfd/bfd_stdint.h', nil, {args=[['#include <stdint.h>\n']]})
	build('sed', '$outdir/bfd/targmatch.h', {'$srcdir/bfd/config.bfd', '|', '$srcdir/bfd/targmatch.sed'}, {
		expr='-f $srcdir/bfd/targmatch.sed',
	})
	build('sed', '$outdir/bfd/elf32-target.h', '$srcdir/bfd/elfxx-target.h', {expr='-e s,NN,32,g'})
	build('sed', '$outdir/bfd/elf64-target.h', '$srcdir/bfd/elfxx-target.h', {expr='-e s,NN,64,g'})
	build('sed', '$outdir/bfd/pex64igen.c', '$srcdir/bfd/peXXigen.c', {expr='-e s,XX,pex64,g'})
	build('sed', '$outdir/bfd/peigen.c', '$srcdir/bfd/peXXigen.c', {expr='-e s,XX,pe,g'})

	-- src/bfd/config.bfd
	for _, vec in ipairs(table.keys(selvecs)) do
		if vec:find('elf64') or vec:find('mips_elf32_n') then
			selvecs.elf64_le_vec = true
			selvecs.elf64_be_vec = true
		end
		if vec:find('elf32') or vec:find('elf64') or vec:find('mips_elf32_n') then
			selvecs.elf32_le_vec = true
			selvecs.elf32_be_vec = true
		end
		if vec:find('iamcu_elf32') then
			selarchs.iamcu = true
		end
		if vec:find('l1om_elf64') then
			selarchs.l1om = true
		end
		if vec:find('k1om_elf64') then
			selarchs.k1om = true
		end
	end
	local srcs = {}
	local special = {
		['dwarf2.c']='bfd/dwarf2.c.o',
		['peigen.c']='$outdir/bfd/peigen.c',
		['pex64igen.c']='$outdir/bfd/pex64igen.c',
	}
	for vec, vecsrcs in pairs(load 'vec.lua') do
		if selvecs[vec] then
			for src in iterstrings(vecsrcs) do
				srcs[special[src] or 'bfd/'..src] = true
			end
		end
	end
	for arch in pairs(selarchs) do
		srcs['bfd/cpu-'..arch..'.c'] = true
	end
	local deps = {
		'$gendir/deps',
		'$outdir/bfd/targmatch.h',
		'$outdir/bfd/elf32-target.h',
		'$outdir/bfd/elf64-target.h',
	}
	local selvecnames = table.keys(selvecs)
	cc('bfd/targets.c', nil, {cflags={
		'$cflags',
		'-D DEFAULT_VECTOR='..defvec,
		'-D HAVE_'..table.concat(selvecnames, ' -D HAVE_'),
		string.format([[-D 'SELECT_VECS=&%s']], table.concat(selvecnames, ',&')),
	}})
	cc('bfd/archures.c', nil, {cflags={
		'$cflags',
		string.format([[-D 'SELECT_ARCHITECTURES=&bfd_%s_arch']], table.concat(table.keys(selarchs), '_arch,&bfd_')),
	}})
	cc('bfd/dwarf2.c', nil, {cflags={'$cflags', string.format([[-D 'DEBUGDIR="%s/lib/debug"']], config.prefix)}})
	lib('libbfd.a', {
		-- src/bfd/Makefile.am:/^BFD32_LIBS_CFILES
		-- src/bfd/Makefile.am:/^BFD64_LIBS_CFILES
		paths[[bfd/(
			archive.c archures.c.o bfd.c bfdio.c bfdwin.c cache.c coff-bfd.c
			compress.c corefile.c elf-properties.c format.c hash.c
			init.c libbfd.c linker.c merge.c opncls.c reloc.c
			section.c simple.c stab-syms.c stabs.c syms.c targets.c.o
			binary.c ihex.c srec.c tekhex.c verilog.c

			archive64.c
		)]],
		table.keys(srcs),
		'libiberty.a',
		'$builddir/pkg/zlib/libz.a',
	}, deps)
end)

sub('opcodes.ninja', function()
	cflags{'-I $dir/opcodes'}
	local srcs = {}
	for arch, archsrcs in pairs(load 'arch.lua') do
		if selarchs[arch] then
			for src in iterstrings(archsrcs) do
				srcs['opcodes/'..src] = true
			end
		end
	end
	cc('opcodes/disassemble.c', nil, {cflags={
		'$cflags', '-D ARCH_'..table.concat(table.keys(selarchs), ' -D ARCH_'),
	}})
	lib('libopcodes.a', {
		paths[[opcodes/(dis-buf.c disassemble.c.o dis-init.c)]],
		table.keys(srcs),
	})
end)

sub('binutils.ninja', function()
	cflags{
		string.format([[-D 'LOCALEDIR="%s/share/locale"']], config.prefix),
		'-D bin_dummy_emulation=bin_vanilla_emulation',
		'-I $dir/binutils',
		'-I $srcdir/binutils',
	}
	lib('libcommon.a', [[
		binutils/(
			bucomm.c version.c filemode.c rename.c
			elfcomm.c
			rddbg.c debug.c stabs.c rdcoff.c wrstabs.c
			dwarf.c demanguse.c
		)
		libbfd.a.d
		libiberty.a
	]])

	cc('binutils/objdump.c', nil, {cflags='$cflags -D OBJDUMP_PRIVATE_VECTORS='})
	exe('bin/size',    [[binutils/size.c                    libcommon.a.d]])
	exe('bin/objcopy', [[binutils/(objcopy.c not-strip.c)   libcommon.a.d]])
	exe('bin/strings', [[binutils/strings.c                 libcommon.a.d]])
	exe('bin/readelf', [[binutils/(readelf.c unwind-ia64.c) libcommon.a.d]])
	exe('bin/elfedit', [[binutils/elfedit.c                 libcommon.a.d]])
	exe('bin/strip',   [[binutils/(objcopy.c.o is-strip.c)  libcommon.a.d]])
	exe('bin/nm',      [[binutils/nm.c                      libcommon.a.d]])
	exe('bin/objdump', [[binutils/(objdump.c.o prdbg.c)     libcommon.a.d libopcodes.a]])

	local arobjs = objects[[
		binutils/(
			arparse.c arlex.c ar.c arsup.c binemul.c
			emul_vanilla.c
		)
		libcommon.a.d
	]]
	exe('bin/ar', {arobjs, 'binutils/not-ranlib.c'})
	exe('bin/ranlib', {arobjs, 'binutils/is-ranlib.c'})

	for _, tool in ipairs{'size', 'objcopy', 'strings', 'readelf', 'elfedit', 'strip', 'nm', 'objdump', 'ar', 'ranlib'} do
		file('bin/'..tool, '755', '$outdir/bin/'..tool)
		man{'binutils/doc/'..tool..'.1'}
		sym(string.format('bin/%s-%s', config.target.platform, tool), tool)
	end
end)

sub('gas.ninja', function()
	cflags{
		'-I $dir/gas',
		'-I $outdir/gas',
		'-I $srcdir/gas',
		'-I $srcdir/gas/config',
		'-I $srcdir',
	}
	build('copy', '$outdir/gas/targ-cpu.h', '$srcdir/gas/config/tc-i386.h')
	build('copy', '$outdir/gas/targ-env.h', '$srcdir/gas/config/te-linux.h')
	build('copy', '$outdir/gas/obj-format.h', '$srcdir/gas/config/obj-elf.h')
	local deps = {
		'$gendir/deps',
		'$outdir/gas/targ-cpu.h',
		'$outdir/gas/targ-env.h',
		'$outdir/gas/obj-format.h',
		'$outdir/bfd/bfdver.h',
	}
	-- src/gas/Makefile.am:/^GAS_CFILES
	exe('bin/as', [[
		gas/(
			app.c
			as.c
			atof-generic.c
			compress-debug.c
			cond.c
			depend.c
			dwarf2dbg.c
			dw2gencfi.c
			ecoff.c
			ehopt.c
			expr.c
			flonum-copy.c
			flonum-konst.c
			flonum-mult.c
			frags.c
			hash.c
			input-file.c
			input-scrub.c
			listing.c
			literal.c
			macro.c
			messages.c
			output-file.c
			read.c
			remap.c
			sb.c
			stabs.c
			subsegs.c
			symbols.c
			write.c

			config/(tc-i386.c obj-elf.c atof-ieee.c)
		)
		libopcodes.a
		libbfd.a.d
	]], deps)
	file('bin/as', '755', '$outdir/bin/as')
	sym(string.format('bin/%s-as', config.target.platform), 'as')
	man{'gas/doc/as.1'}
end)

sub('ld.ninja', function()
	cflags{
		'-D ELF_LIST_OPTIONS=true',
		'-D ELF_SHLIB_LIST_OPTIONS=true',
		'-D ELF_PLT_UNWIND_LIST_OPTIONS=true',
		string.format([[-D 'BINDIR="%s/bin"']], config.prefix),
		string.format([[-D 'SCRIPTDIR="%s/%s/lib"']], config.prefix, config.target.platform),
		string.format([[-D 'TOOLBINDIR="%s/%s/bin"']], config.prefix, config.target.platform),
		'-I $dir/ld',
		'-I $outdir/ld',
		'-I $srcdir/ld',
	}
	local deps = {
		'$gendir/deps',
		'$outdir/ld/ldemul-list.h',
	}

	rule('ldemul', 'sh $dir/ldemul.sh $emuls >$out')
	build('ldemul', '$outdir/ld/ldemul-list.h', {'|', '$dir/ldemul.sh'}, {emuls=emuls})

	build('copy', '$outdir/ld/stringify.sed', '$srcdir/ld/emultempl/astring.sed')
	rule('genscripts', string.format([[cd $outdir/ld && LIB_PATH= sh $$OLDPWD/$srcdir/ld/genscripts.sh $$OLDPWD/$srcdir/ld /lib '' '' %s %s %s '' /lib '%s' /lib no yes $emul %s]], config.target.platform, config.target.platform, config.target.platform, table.concat(emuls, ' '), config.target.platform))
	local srcs = {}
	for _, emul in ipairs(emuls) do
		local out = string.format('$outdir/ld/e%s.c', emul)
		table.insert(srcs, out)
		build('genscripts', string.format('$outdir/ld/e%s.c', emul), {'|', '$srcdir/ld/genscripts.sh', '$outdir/ld/stringify.sed'}, {
			emul=emul,
		})
	end

	cc('ld/ldmain.c', nil, {cflags={
		'$cflags',
		string.format([[-D 'DEFAULT_EMULATION="%s"']], emuls[1]),
		string.format([[-D 'TARGET="%s"']], 'x86_64-pc-linux-musl'),
	}})
	exe('bin/ld', {
		-- src/ld/Makefile.am:/^ld_new_SOURCES
		-- src/ld/configure.tgt:/^targ_extra_ofiles
		paths[[
			ld/(
				ldgram.c ldlex-wrapper.c lexsup.c ldlang.c mri.c ldctor.c ldmain.c.o
				ldwrite.c ldexp.c ldemul.c ldver.c ldmisc.c ldfile.c ldcref.c plugin.c
				ldbuildid.c

				ldelf.c ldelfgen.c
			)
			libbfd.a.d
		]],
		srcs,
	}, deps)
	file('bin/ld', '755', '$outdir/bin/ld')
	sym(string.format('bin/%s-ld', config.target.platform), 'ld')
	man{'ld/ld.1'}
end)

fetch 'curl'
