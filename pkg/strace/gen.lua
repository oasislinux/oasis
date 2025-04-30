local arch = ({
	aarch64='aarch64',
	x86_64='x86_64',
})[config.target.platform:match('[^-]*')]
-- NOTE: strace is architecture specific, skip generation on unsupported archs
if not arch then return end

cflags{
	'-D HAVE_CONFIG_H',
	'-D IN_STRACE',
	-- it is important that the arch-specific directory is searched first
	'-I $srcdir/src/linux/'..arch,
	'-I $srcdir/src/linux/generic',
	'-I $srcdir/src',
	'-I $outdir',
	'-isystem $builddir/pkg/linux-headers/include',
}

local arch_cflags = {}
arch_cflags['aarch64'] = {'-D AARCH64=1'}
arch_cflags['x86_64']  = {
	'-D X86_64=1',
	'-D HAVE_STRUCT_KVM_CPUID2=1',
	'-D HAVE_STRUCT_USER_DESC=1',
	'-D HAVE_STRUCT_USER_DESC_LM=1',
	'-D HAVE_STRUCT___OLD_KERNEL_STAT=1',
}
cflags(arch_cflags[arch])

build('cat', '$outdir/config.h', {
	'$builddir/probe/HAVE___BUILTIN_POPCOUNT',
	'$dir/config.h',
})

build('cpp', '$outdir/ioctl_iocdef.i', '$srcdir/src/ioctl_iocdef.c')
build('sed', '$outdir/ioctl_iocdef.h', '$outdir/ioctl_iocdef.i', {
	expr=[[-n 's/^DEFINE HOST/#define /p']],
})

sub('tools.ninja', function()
	toolchain(config.host)
	cflags{
		'-I $srcdir/src/linux/'..arch,
		'-I $srcdir/src/linux',
		'-I $outdir',
	}
	cflags(arch_cflags[arch])

	local arch_h_count = {
		aarch64=1,
		x86_64=2,
	}

	for i = 0, arch_h_count[arch] do
		build('cat', '$outdir/ioctls_all'..i..'.h', {
			'$srcdir/src/linux/'..arch..'/ioctls_inc'..i..'.h',
			'$srcdir/src/linux/'..arch..'/ioctls_arch'..i..'.h',
		})
		build('cc', '$outdir/ioctlsort'..i..'.c.o', {
			'$srcdir/src/ioctlsort.c',
			'|', '$outdir/ioctl_iocdef.h', '$srcdir/ioctls_zfs.h', '$outdir/ioctls_all'..i..'.h',
		}, {cflags=string.format([[$cflags -D 'IOCTLSORT_INC="ioctls_all%d.h"']], i)})
		exe('ioctlsort'..i, {'ioctlsort'..i..'.c.o'})
		rule('ioctlsort'..i, '$outdir/ioctlsort'..i..' >$out')
		build('ioctlsort'..i, '$outdir/ioctlent'..i..'.h', {'|', '$outdir/ioctlsort'..i})
	end
end)

local mpers = lines('mpers.txt')
for _, f in ipairs(mpers) do
	build('cpp', '$outdir/'..f..'.mpers.i', {'$srcdir/src/'..f, '|', '$outdir/config.h'}, {
		cflags='$cflags -DIN_MPERS_BOOTSTRAP',
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

build('cpp', '$outdir/syscallent.i', '$srcdir/src/linux/x86_64/syscallent.h')
build('awk', '$outdir/scno-syscallent.h', {'$outdir/syscallent.i', '|', '$dir/scno.awk'}, {
	expr='-f $dir/scno.awk',
})
build('cat', '$outdir/scno.h', {'$srcdir/src/scno.head', '$outdir/scno-syscallent.h'})

-- this seems to be enough syscall headers to build
local syscalls = expand{'$srcdir/src/linux/', {
	'32/syscallent.h',
	'64/syscallent.h',
	'arm/syscallent.h',
	'i386/syscallent.h',
	'sparc/syscallent.h',
	'sparc64/syscallent.h',
	'generic/subcallent.h',
	'generic/syscallent-common.h',
	'x86_64/syscallent.h',
}}
build('awk', '$outdir/sen.h', {syscalls, '|', '$dir/sen.awk'}, {
	expr='-f $dir/sen.awk',
})

local srcs = paths[[src/(
	access.c
	affinity.c
	aio.c
	alpha.c
	basic_filters.c
	bind.c
	bjm.c
	block.c
	bpf.c
	bpf_filter.c
	bpf_seccomp_filter.c
	bpf_sock_filter.c
	btrfs.c
	cacheflush.c
	cachestat.c
	capability.c
	chdir.c
	chmod.c
	clone.c
	close_range.c
	copy_file_range.c
	count.c
	counter_ioctl.c
	delay.c
	desc.c
	dirent.c
	dirent64.c
	dirent_types.c
	dm.c
	dup.c
	dyxlat.c
	epoll.c
	epoll_ioctl.c
	error_prints.c
	evdev.c
	evdev_mpers.c
	eventfd.c
	execve.c
	exitkill.c
	fadvise.c
	fallocate.c
	fanotify.c
	fchownat.c
	fcntl.c
	fetch_bpf_fprog.c
	fetch_indirect_syscall_args.c
	fetch_struct_flock.c
	fetch_struct_iovec.c
	fetch_struct_keyctl_kdf_params.c
	fetch_struct_mmsghdr.c
	fetch_struct_msghdr.c
	fetch_struct_stat.c
	fetch_struct_stat64.c
	fetch_struct_statfs.c
	fetch_struct_xfs_quotastat.c
	file_handle.c
	filter_qualify.c
	filter_seccomp.c
	flock.c
	fs_0x94_ioctl.c
	fs_f_ioctl.c
	fs_x_ioctl.c
	fsconfig.c
	fsmount.c
	fsopen.c
	fspick.c
	fstatfs.c
	fstatfs64.c
	futex.c
	futex2.c
	gen/gen_hdio.c
	get_personality.c
	get_robust_list.c
	getcpu.c
	getcwd.c
	getpagesize.c
	getpid.c
	getrandom.c
	gpio_ioctl.c
	hdio.c
	hostname.c
	inotify.c
	inotify_ioctl.c
	io.c
	io_uring.c
	ioctl.c
	ioperm.c
	ioprio.c
	ipc.c
	ipc_msg.c
	ipc_msgctl.c
	ipc_sem.c
	ipc_semctl.c
	ipc_shm.c
	ipc_shmctl.c
	kcmp.c
	kd_ioctl.c
	kd_mpers_ioctl.c
	kexec.c
	keyctl.c
	kvm.c
	landlock.c
	ldt.c
	link.c
	lirc_ioctl.c
	listen.c
	listmount.c
	lookup_dcookie.c
	loop.c
	lseek.c
	lsm.c
	map_shadow_stack.c
	mem.c
	membarrier.c
	memfd_create.c
	memfd_secret.c
	mknod.c
	mmap_cache.c
	mmap_notify.c
	mmsghdr.c
	mount.c
	mount_setattr.c
	move_mount.c
	mq.c
	msghdr.c
	mtd.c
	nbd_ioctl.c
	net.c
	netlink.c
	netlink_crypto.c
	netlink_generic.c
	netlink_inet_diag.c
	netlink_kobject_uevent.c
	netlink_netfilter.c
	netlink_netlink_diag.c
	netlink_nlctrl.c
	netlink_packet_diag.c
	netlink_route.c
	netlink_selinux.c
	netlink_smc_diag.c
	netlink_sock_diag.c
	netlink_unix_diag.c
	nlattr.c
	nsfs.c
	numa.c
	number_set.c
	oldstat.c
	open.c
	open_tree.c
	or1k_atomic.c
	pathtrace.c
	perf.c
	perf_ioctl.c
	personality.c
	pidfd_getfd.c
	pidfd_open.c
	pidns.c
	pkeys.c
	poke.c
	poll.c
	prctl.c
	print_dev_t.c
	print_group_req.c
	print_ifindex.c
	print_instruction_pointer.c
	print_kernel_sigset.c
	print_kernel_version.c
	print_mac.c
	print_mq_attr.c
	print_msgbuf.c
	print_sg_req_info.c
	print_sigevent.c
	print_statfs.c
	print_struct_stat.c
	print_syscall_number.c
	print_time.c
	print_timespec32.c
	print_timespec64.c
	print_timeval.c
	print_timeval64.c
	print_timex.c
	printmode.c
	printrusage.c
	printsiginfo.c
	process_vm.c
	ptp.c
	ptrace.c
	ptrace_syscall_info.c
	quota.c
	random_ioctl.c
	readahead.c
	readlink.c
	reboot.c
	regset.c
	renameat.c
	resource.c
	retval.c
	riscv.c
	rt_sigframe.c
	rt_sigreturn.c
	rtc.c
	rtnl_addr.c
	rtnl_addrlabel.c
	rtnl_cachereport.c
	rtnl_dcb.c
	rtnl_link.c
	rtnl_mdb.c
	rtnl_neigh.c
	rtnl_neightbl.c
	rtnl_netconf.c
	rtnl_nh.c
	rtnl_nsid.c
	rtnl_route.c
	rtnl_rule.c
	rtnl_stats.c
	rtnl_tc.c
	rtnl_tc_action.c
	s390.c
	sched.c
	scsi.c
	seccomp.c
	seccomp_ioctl.c
	sendfile.c
	sg_io_v3.c
	sg_io_v4.c
	shutdown.c
	sigaltstack.c
	signal.c
	signalfd.c
	sigreturn.c
	sock.c
	sockaddr.c
	socketcall.c
	socketutils.c
	sparc.c
	sram_alloc.c
	stage_output.c
	stat.c
	stat64.c
	statfs.c
	statfs64.c
	statmount.c
	statx.c
	strauss.c
	string_to_uint.c
	swapon.c
	sync_file_range.c
	sync_file_range2.c
	syscall.c
	syscall_name.c
	sysctl.c
	sysinfo.c
	syslog.c
	sysmips.c
	tee.c
	term.c
	time.c
	times.c
	trie.c
	truncate.c
	ubi.c
	ucopy.c
	uid.c
	uid16.c
	umask.c
	umount.c
	uname.c
	upeek.c
	upoke.c
	userfaultfd.c
	ustat.c
	util.c
	utime.c
	utimes.c
	v4l2.c
	wait.c
	watchdog_ioctl.c
	xattr.c
	xgetdents.c
	xlat.c
	xmalloc.c
)]]

build('sed', '$outdir/sys_func.h', expand{'$srcdir/', srcs}, {
	expr=[[-n 's/^SYS_FUNC(.*/extern &;/p']],
})

pkg.deps = {
	'$outdir/config.h',
	'$outdir/ioctlent0.h',
	'$outdir/ioctlent1.h',
	'$outdir/ioctlent2.h',
	'$outdir/native_printer_decls.h',
	'$outdir/native_printer_defs.h',
	'$outdir/printers.h',
	'$outdir/scno.h',
	'$outdir/sen.h',
	'$outdir/sys_func.h',
	'pkg/linux-headers/headers',
}

lib('libstrace.a', srcs)
exe('strace', {'src/strace.c', 'libstrace.a'})
file('bin/strace', '755', '$outdir/strace')

build('sed', '$outdir/strace.1', '$srcdir/doc/strace.1.in', {
	expr={
		[[-e 's,@STRACE_MANPAGE_DATE@,2024-06-30,']],
		[[-e 's,@VERSION@,6.12,']],
		[[-e 's,@ENABLE_STACKTRACE_TRUE@,#,']],
		[[-e 's,@ENABLE_STACKTRACE_FALSE@,,']],
		[[-e 's,@ENABLE_SECONTEXT_TRUE@,#,']],
		[[-e 's,@ENABLE_SECONTEXT_FALSE@,,']],
	},
})
man{'$outdir/strace.1'}

fetch 'curl'
