cflags{
	'-D HAVE_CONFIG_H',
	'-I include',
	'-I $dir',
	-- it is important that the arch-specific directory is searched first
	'-I $srcdir/linux/x86_64',
	'-I $srcdir/linux',
	'-I $srcdir',
	'-I $outdir',
}

build('cc', '$outdir/ioctl_iocdef.i', '$srcdir/ioctl_iocdef.c', {
	cflags='$cflags -P -E -MT $outdir/ioctl_iocdef.i',
})
build('sed', '$outdir/ioctl_iocdef.h', '$outdir/ioctl_iocdef.i', {
	expr=[[-n 's/^DEFINE HOST/#define /p']],
})

sub('tools.ninja', function()
	toolchain 'host'
	cflags{
		'-D X86_64=1',
		'-I $srcdir/linux/x86_64',
		'-I $srcdir/linux',
		'-I $outdir',
	}

	for i = 0, 2 do
		build('cat', '$outdir/ioctls_all'..i..'.h', {
			'$srcdir/linux/x86_64/ioctls_inc'..i..'.h',
			'$srcdir/linux/x86_64/ioctls_arch'..i..'.h',
		})
		build('cc', '$outdir/ioctlsort'..i..'.c.o', {
			'$srcdir/ioctlsort.c',
			'|', '$outdir/ioctl_iocdef.h', '$outdir/ioctls_all'..i..'.h',
		}, {cflags=string.format([[$cflags -D 'IOCTLSORT_INC="ioctls_all%d.h"']], i)})
		exe('ioctlsort'..i, {'ioctlsort'..i..'.c.o'})
		rule('ioctlsort'..i, '$outdir/ioctlsort'..i..' >$out.tmp && mv $out.tmp $out')
		build('ioctlsort'..i, '$outdir/ioctlent'..i..'.h', {'|', '$outdir/ioctlsort'..i})
	end
end)

local mpers = lines('mpers.txt')
for _, f in ipairs(mpers) do
	build('cc', '$outdir/'..f..'.mpers.i', '$srcdir/'..f, {
		cflags='$cflags -P -E -MT $outdir/'..f..'.mpers.i -DIN_MPERS_BOOTSTRAP',
	})
end

local function makempers(name, script)
	build('awk', '$outdir/'..name, {expand{'$outdir/', mpers, '.mpers.i'}, '|', '$dir/'..script}, {
		expr='-f $dir/'..script,
	})
end

makempers('printers.h', 'printers.awk')
makempers('native_printer_decls.h', 'printerdecls.awk')
makempers('native_printer_defs.h', 'printerdefs.awk')

build('cc', '$outdir/syscallent.i', '$srcdir/linux/x86_64/syscallent.h', {
	cflags='$cflags -P -E -MT $outdir/syscallent.i',
})
build('awk', '$outdir/scno-syscallent.h', {'$outdir/syscallent.i', '|', '$dir/scno.awk'}, {
	expr='-f $dir/scno.awk',
})
build('cat', '$outdir/scno.h', {'$srcdir/scno.head', '$outdir/scno-syscallent.h'})

-- this seems to be enough syscall headers to build
local syscalls = expand{'$srcdir/linux/', {
	'subcall.h',
	'arm/syscallent.h',
	'32/syscallent.h',
	'64/syscallent.h',
	'i386/syscallent.h',
	'x86_64/syscallent.h',
}}
build('awk', '$outdir/sen.h', {syscalls, '|', '$dir/sen.awk'}, {
	expr='-f $dir/sen.awk',
})

local libsrcs = {
	'fstatfs.c',
	'fstatfs64.c',
	'ipc.c',
	'sigreturn.c',
	'socketcall.c',
	'statfs.c',
	'statfs64.c',
	'sync_file_range.c',
	'sync_file_range2.c',
	'upeek.c',
	'upoke.c',
}
local srcs = {
	'access.c',
	'affinity.c',
	'aio.c',
	'alpha.c',
	'bjm.c',
	'block.c',
	'bpf.c',
	'btrfs.c',
	'cacheflush.c',
	'capability.c',
	'chdir.c',
	'chmod.c',
	'clone.c',
	'copy_file_range.c',
	'count.c',
	'desc.c',
	'dirent.c',
	'dirent64.c',
	'dm.c',
	'dyxlat.c',
	'epoll.c',
	'evdev.c',
	'eventfd.c',
	'execve.c',
	'fadvise.c',
	'fallocate.c',
	'fanotify.c',
	'fchownat.c',
	'fcntl.c',
	'fetch_seccomp_fprog.c',
	'fetch_struct_flock.c',
	'fetch_struct_mmsghdr.c',
	'fetch_struct_msghdr.c',
	'fetch_struct_stat.c',
	'fetch_struct_stat64.c',
	'fetch_struct_statfs.c',
	'file_handle.c',
	'file_ioctl.c',
	'fs_x_ioctl.c',
	'flock.c',
	'futex.c',
	'get_robust_list.c',
	'getcpu.c',
	'getcwd.c',
	'getrandom.c',
	'hdio.c',
	'hostname.c',
	'inotify.c',
	'io.c',
	'ioctl.c',
	'ioperm.c',
	'iopl.c',
	'ioprio.c',
	'ipc_msg.c',
	'ipc_msgctl.c',
	'ipc_sem.c',
	'ipc_shm.c',
	'ipc_shmctl.c',
	'kcmp.c',
	'kexec.c',
	'keyctl.c',
	'ldt.c',
	'link.c',
	'lookup_dcookie.c',
	'loop.c',
	'lseek.c',
	'mem.c',
	'membarrier.c',
	'memfd_create.c',
	'mknod.c',
	'mmsghdr.c',
	'mount.c',
	'mq.c',
	'msghdr.c',
	'mtd.c',
	'net.c',
	'netlink.c',
	'netlink_sock_diag.c',
	'nlattr.c',
	'nsfs.c',
	'numa.c',
	'oldstat.c',
	'open.c',
	'or1k_atomic.c',
	'pathtrace.c',
	'perf.c',
	'personality.c',
	'pkeys.c',
	'poll.c',
	'prctl.c',
	'print_dev_t.c',
	'print_mq_attr.c',
	'print_msgbuf.c',
	'print_sg_req_info.c',
	'print_sigevent.c',
	'print_statfs.c',
	'print_struct_stat.c',
	'print_time.c',
	'print_timespec.c',
	'print_timeval.c',
	'print_timex.c',
	'printmode.c',
	'printrusage.c',
	'printsiginfo.c',
	'process.c',
	'process_vm.c',
	'ptp.c',
	'qualify.c',
	'quota.c',
	'readahead.c',
	'readlink.c',
	'reboot.c',
	'renameat.c',
	'resource.c',
	'rt_sigframe.c',
	'rt_sigreturn.c',
	'rtc.c',
	'sched.c',
	'scsi.c',
	'seccomp.c',
	'sendfile.c',
	'sg_io_v3.c',
	'sg_io_v4.c',
	'sigaltstack.c',
	'signal.c',
	'signalfd.c',
	'sock.c',
	'sockaddr.c',
	'socketutils.c',
	'sram_alloc.c',
	'stat.c',
	'stat64.c',
	'statx.c',
	'strace.c',
	'swapon.c',
	'syscall.c',
	'sysctl.c',
	'sysinfo.c',
	'syslog.c',
	'sysmips.c',
	'term.c',
	'time.c',
	'times.c',
	'truncate.c',
	'ubi.c',
	'uid.c',
	'uid16.c',
	'umask.c',
	'umount.c',
	'uname.c',
	'userfaultfd.c',
	'ustat.c',
	'util.c',
	'utime.c',
	'utimes.c',
	'v4l2.c',
	'wait.c',
	'xattr.c',
	'xlat.c',
	'xmalloc.c',
}

build('sed', '$outdir/sys_func.h', expand{'$srcdir/', {libsrcs, srcs}}, {
	expr=[[-n 's/^SYS_FUNC(.*/extern &;/p']],
})

pkg.deps = {
	'$outdir/ioctlent0.h',
	'$outdir/ioctlent1.h',
	'$outdir/ioctlent2.h',
	'$outdir/native_printer_decls.h',
	'$outdir/native_printer_defs.h',
	'$outdir/printers.h',
	'$outdir/scno.h',
	'$outdir/sen.h',
	'$outdir/sys_func.h',
}

lib('libstrace.a', libsrcs, {'$outdir/printers.h'})
exe('strace', {srcs, 'libstrace.a'})
file('bin/strace', '755', '$outdir/strace')
man{'strace.1'}

fetch 'curl'
