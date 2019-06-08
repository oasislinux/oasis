cflags{
        '-D HAVE_CONFIG_H',
        '-D _GNU_SOURCE',
        '-I $dir',
        '-I $srcdir/lib',
        '-I $srcdir/libelf',
        '-I $builddir/pkg/zlib/include',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/libelf', {'libelf.h', 'gelf.h'})

lib('libelf.a', [[libelf/(
        elf_version.c elf_hash.c elf_error.c elf_fill.c
        elf_begin.c elf_next.c elf_rand.c elf_end.c elf_kind.c
        gelf_getclass.c elf_getbase.c elf_getident.c
        elf32_fsize.c elf64_fsize.c gelf_fsize.c
        elf32_xlatetof.c elf32_xlatetom.c elf64_xlatetof.c
        elf64_xlatetom.c gelf_xlate.c
        elf32_getehdr.c elf64_getehdr.c gelf_getehdr.c
        elf32_newehdr.c elf64_newehdr.c gelf_newehdr.c
        gelf_update_ehdr.c
        elf32_getphdr.c elf64_getphdr.c gelf_getphdr.c
        elf32_newphdr.c elf64_newphdr.c gelf_newphdr.c
        gelf_update_phdr.c
        elf_getarhdr.c elf_getarsym.c
        elf_rawfile.c elf_readall.c elf_cntl.c
        elf_getscn.c elf_nextscn.c elf_ndxscn.c elf_newscn.c
        elf32_getshdr.c elf64_getshdr.c gelf_getshdr.c
        gelf_update_shdr.c
        elf_strptr.c elf_rawdata.c elf_getdata.c elf_newdata.c
        elf_getdata_rawchunk.c
        elf_flagelf.c elf_flagehdr.c elf_flagphdr.c elf_flagscn.c
        elf_flagshdr.c elf_flagdata.c elf_memory.c
        elf_update.c elf32_updatenull.c elf64_updatenull.c
        elf32_updatefile.c elf64_updatefile.c
        gelf_getsym.c gelf_update_sym.c
        gelf_getversym.c gelf_getverneed.c gelf_getvernaux.c
        gelf_getverdef.c gelf_getverdaux.c
        gelf_getrel.c gelf_getrela.c
        gelf_update_rel.c gelf_update_rela.c
        gelf_getdyn.c gelf_update_dyn.c
        gelf_getmove.c gelf_update_move.c
        gelf_getsyminfo.c gelf_update_syminfo.c
        gelf_getauxv.c gelf_update_auxv.c
        gelf_getnote.c
        gelf_xlatetof.c gelf_xlatetom.c
        nlist.c
        gelf_getsymshndx.c gelf_update_symshndx.c
        gelf_update_versym.c gelf_update_verneed.c
        gelf_update_vernaux.c gelf_update_verdef.c
        gelf_update_verdaux.c
        elf_getphdrnum.c elf_getshdrnum.c elf_getshdrstrndx.c
        gelf_checksum.c elf32_checksum.c elf64_checksum.c
        libelf_crc32.c libelf_next_prime.c
        elf_clone.c
        gelf_getlib.c gelf_update_lib.c
        elf32_offscn.c elf64_offscn.c gelf_offscn.c
        elf_getaroff.c
        elf_gnu_hash.c
        elf_scnshndx.c
        elf32_getchdr.c elf64_getchdr.c gelf_getchdr.c
        elf_compress.c elf_compress_gnu.c
)]])

fetch 'git'
