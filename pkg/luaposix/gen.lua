cflags{
	'-std=c99',
	'-D _GNU_SOURCE',
	'-include $dir/config.h',
	'-I $srcdir/ext/include',
	'-isystem $builddir/pkg/lua/include',
}

pkg.deps = {
	'pkg/lua/headers',
}

build('sed', '$outdir/version.lua', '$srcdir/lib/posix/version.lua.in', {
	expr={
		'-e s,@package@,luaposix,',
		'-e s,@version2,36.2.1,',
	},
})

lib('libluaposix.a', [[
	ext/posix/(
		ctype.c
		dirent.c
		errno.c
		fcntl.c
		fnmatch.c
		glob.c
		grp.c
		libgen.c
		poll.c
		pwd.c
		sched.c
		signal.c
		stdio.c
		stdlib.c
		sys/(
			msg.c
			resource.c
			socket.c
			stat.c
			statvfs.c
			time.c
			times.c
			utsname.c
			wait.c
		)
		syslog.c
		termio.c
		time.c
		unistd.c
		utime.c
	)
]])

local files = {
	'init.lua',
	'_base.lua',
	'_bitwise.lua',
	'_strict.lua',
	'compat.lua',
	'sys.lua',
	'util.lua',
}
for _, f in ipairs(files) do
	file('share/lua/5.4/posix/'..f, '644', '$srcdir/lib/posix/'..f)
end
file('share/lua/5.4/posix/version.lua', '644', '$outdir/version.lua')

fetch 'git'
