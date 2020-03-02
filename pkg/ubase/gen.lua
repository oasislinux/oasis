cflags{
	'-std=c99', '-Wall', '-Wpedantic', '-Wno-maybe-uninitialized', '-Wno-overflow',
	'-D _GNU_SOURCE',
	'-D _XOPEN_SOURCE=700',
	'-I $dir',
}

lib('libutil.a', [[libutil/(
	agetcwd.c
	agetline.c
	apathmax.c
	concat.c
	ealloc.c
	eprintf.c
	estrtol.c
	estrtoul.c
	explicit_bzero.c
	passwd.c
	proc.c
	putword.c
	recurse.c
	strlcat.c
	strlcpy.c
	strtonum.c
	tty.c
)]])

local tools = {
	{'blkdiscard', 8},
	{'chvt', 1},
	{'clear', 1},
	{'ctrlaltdel', 8},
	{'dd', 1},
	{'df', 1},
	{'dmesg', 1},
	{'eject', 1},
	{'fallocate', 1},
	{'free', 1},
	{'freeramdisk', 8},
	{'fsfreeze', 8},
	{'getty', 8},
	{'halt', 8},
	{'hwclock', 8},
	{'id', 1},
	{'insmod', 8},
	{'killall5', 8},
	{'last'},
	{'lastlog', 8},
	{'login', 1},
	{'lsmod', 8},
	{'lsusb', 8},
	{'mesg', 1},
	{'mkswap', 8},
	{'mount', 8},
	{'mountpoint', 1},
	{'nologin', 8},
	{'pagesize', 1},
	{'passwd', 1, '4755'},
	{'pidof', 1},
	{'pivot_root', 8},
	{'ps', 1},
	{'pwdx', 1},
	{'readahead', 8},
	{'respawn', 1},
	{'rmmod', 8},
	{'stat', 1},
	{'stty'},
	{'swaplabel', 8},
	{'swapoff', 8},
	{'swapon', 8},
	{'switch_root', 8},
	{'sysctl', 8},
	{'truncate', 1},
	{'umount', 8},
	{'unshare', 1},
	{'uptime', 1},
	{'vmstat'},
	{'vtallow', 1},
	{'watch', 1},
	{'who', 1},
}

for _, tool in ipairs(tools) do
	local name, sect, mode = table.unpack(tool)
	file('bin/'..name, mode or '755', exe(name, {name..'.c', 'libutil.a'}))
	if sect then
		man{name..'.'..sect}
	end
end

fetch 'git'
