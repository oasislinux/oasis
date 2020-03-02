local version = setmetatable({2, 34}, {__index=function() return 0 end})
local defvec = 'x86_64_elf64_vec'
local selvecs = {[defvec]=true, i386_elf32_vec=true}
local selarchs = {bfd_i386_arch=true}
local emuls = {
	'elf_x86_64',
	'elf_i386',
}

cflags{
	'-D HAVE_CONFIG_H',
	'-I $srcdir/include',
	'-I $outdir/bfd',
	'-I $srcdir/bfd',
	'-I $builddir/pkg/zlib/include',
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

sub('libctf.ninja', function()
	cflags{
		'-I $dir/libctf',
		'-I $srcdir/libctf',
	}
	-- src/libctf/Makefile.am:/^libctf_nobfd_la_SOURCES
	lib('libctf.a', [[
		libctf/(
			ctf-archive.c ctf-dump.c ctf-create.c ctf-decl.c ctf-error.c
			ctf-hash.c ctf-labels.c ctf-link.c ctf-lookup.c ctf-open.c
			ctf-string.c ctf-subr.c ctf-types.c ctf-util.c
			ctf-qsort_r.c

			ctf-open-bfd.c
		)
		libiberty.a
		$builddir/pkg/zlib/libz.a
	]])
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
	for vec in pairs(selvecs) do
		if vec:find('elf64') or vec:find('mips_elf32_n') then
			selvecs.elf64_le_vec = true
			selvecs.elf64_be_vec = true
		end
		if vec:find('elf32') or vec:find('elf64') or vec:find('mips_elf32_n') then
			selvecs.elf32_le_vec = true
			selvecs.elf32_be_vec = true
		end
		if vec:find('iamcu_elf32') then
			selarchs.bfd_iamcu_arch = true
		end
		if vec:find('l1om_elf64') then
			selarchs.bfd_l1om_arch = true
		end
		if vec:find('k1om_elf64') then
			selarchs.bfd_k1om_arch = true
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
		srcs['bfd/cpu-'..arch:match('bfd_(%g+)_arch')..'.c'] = true
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
		string.format([[-D 'SELECT_ARCHITECTURES=&%s']], table.concat(table.keys(selarchs), ',&')),
	}})
	cc('bfd/dwarf2.c', nil, {cflags={'$cflags', [[-D 'DEBUGDIR="/lib/debug"']]}})
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
	lib('libopcodes.a', {
		paths[[opcodes/(dis-buf.c disassemble.c dis-init.c)]],
		table.keys(srcs),
	})
end)

sub('binutils.ninja', function()
	cflags{
		[[-D 'LOCALEDIR="/share/locale"']],
		'-D bin_dummy_emulation=bin_vanilla_emulation',
		'-I $dir/binutils',
		'-I $srcdir/binutils',
	}
	lib('libbu.a', [[
		binutils/(
			bucomm.c version.c filemode.c rename.c
			elfcomm.c
			rddbg.c debug.c stabs.c rdcoff.c wrstabs.c
		)
	]])

	cc('binutils/objcopy.c')
	cc('binutils/dwarf.c')
	cc('binutils/objdump.c', nil, {cflags='$cflags -D OBJDUMP_PRIVATE_VECTORS='})
	exe('bin/size', [[binutils/size.c libbu.a libbfd.a.d]])
	exe('bin/objcopy', [[binutils/(objcopy.c.o not-strip.c) libbu.a libbfd.a.d]])
	exe('bin/strings', [[binutils/strings.c libbu.a libbfd.a.d]])
	exe('bin/readelf', [[binutils/(readelf.c unwind-ia64.c dwarf.c.o) libbu.a libctf.a.d]])
	exe('bin/elfedit', [[binutils/elfedit.c libbu.a libbfd.a.d]])
	exe('bin/strip', [[binutils/(objcopy.c.o is-strip.c) libbu.a libbfd.a.d]])
	exe('bin/nm', [[binutils/nm.c libbu.a libbfd.a.d]])
	exe('bin/objdump', [[binutils/(objdump.c.o dwarf.c.o prdbg.c) libbu.a libbfd.a.d libopcodes.a libctf.a.d]])

	local arobjs = objects[[
		binutils/(
			arparse.c arlex.c ar.c arsup.c binemul.c
			emul_vanilla.c
		)
		libbu.a libbfd.a.d
	]]
	exe('bin/ar', {arobjs, 'binutils/not-ranlib.c'})
	exe('bin/ranlib', {arobjs, 'binutils/is-ranlib.c'})

	for _, tool in ipairs{'size', 'objcopy', 'strings', 'readelf', 'elfedit', 'strip', 'nm', 'objdump', 'ar', 'ranlib'} do
		file('bin/'..tool, '755', '$outdir/bin/'..tool)
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
		'-D ELF_LIST_OPTIONS=TRUE',
		'-D ELF_SHLIB_LIST_OPTIONS=TRUE',
		'-D ELF_PLT_UNWIND_LIST_OPTIONS=TRUE',
		[[-D 'BINDIR="/bin"']],
		string.format([[-D 'SCRIPTDIR="/%s/lib"']], config.target.platform),
		string.format([[-D 'TOOLBINDIR="/%s/bin"']], config.target.platform),
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
				ldwrite.c ldexp.c ldemul.c ldver.c ldmisc.c ldfile.c ldcref.c
				ldbuildid.c

				ldelf.c ldelfgen.c
			)
			libbfd.a.d
			libctf.a.d
		]],
		srcs,
	}, deps)
	file('bin/ld', '755', '$outdir/bin/ld')
	sym(string.format('bin/%s-ld', config.target.platform), 'ld')
	man{'ld/ld.1'}
end)

fetch 'curl'
