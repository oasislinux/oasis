cflags{
	'-I $dir',
	'-I $srcdir/src/core',
	'-I $srcdir/src/event',
	'-I $srcdir/src/os/unix',
	'-I $builddir/pkg/linux-headers/include',
}
local libs = {}
pkg.deps = {'pkg/linux-headers/headers'}

local modules = {}
for line in iterlines('modules.txt') do
	modules[line] = true
end

if modules['openssl'] then
	cflags{'-I $builddir/pkg/libressl/include'}
	table.insert(libs, {
		'$builddir/pkg/libressl/libssl.a.d',
		'$builddir/pkg/libressl/libcrypto.a.d',
	})
	table.insert(pkg.deps, 'pkg/libressl/headers')
end
if modules['regex'] then
	cflags{'-I $builddir/pkg/pcre/include'}
	table.insert(libs, '$builddir/pkg/pcre/libpcre.a')
	table.insert(pkg.deps, 'pkg/pcre/headers')
end
local zlib = modules['http_gzip_filter'] or modules['http_gunzip_filter']
for line in iterlines('ngx_auto_config.h', 1) do
	if line == 'NGX_ZLIB 1' then
		zlib = true
		break
	end
end
if zlib then
	cflags{'-I $builddir/pkg/zlib/include'}
	table.insert(libs, '$builddir/pkg/zlib/libz.a')
	table.insert(pkg.deps, 'pkg/zlib/headers')
end
if modules['http'] then
	cflags{'-I $srcdir/src/http', '-I $srcdir/src/http/modules'}
end
if modules['mail'] then
	cflags{'-I $srcdir/src/mail'}
end
if modules['stream'] then
	cflags{'-I $srcdir/src/stream'}
end

build('awk', '$outdir/ngx_modules.c', {'$dir/modules.txt', '|', '$dir/modules.awk', '$dir/sources.txt'}, {
	expr='-f $dir/modules.awk -v sources=$dir/sources.txt'
})
cc('$outdir/ngx_modules.c', {'$gendir/deps', '$dir/fetch'})

local sources = paths[[src/(
	core/(
		nginx.c
		ngx_log.c
		ngx_palloc.c
		ngx_array.c
		ngx_list.c
		ngx_hash.c
		ngx_buf.c
		ngx_queue.c
		ngx_output_chain.c
		ngx_string.c
		ngx_parse.c
		ngx_parse_time.c
		ngx_inet.c
		ngx_file.c
		ngx_crc32.c
		ngx_murmurhash.c
		ngx_md5.c
		ngx_sha1.c
		ngx_rbtree.c
		ngx_radix_tree.c
		ngx_slab.c
		ngx_times.c
		ngx_shmtx.c
		ngx_connection.c
		ngx_cycle.c
		ngx_spinlock.c
		ngx_rwlock.c
		ngx_cpuinfo.c
		ngx_conf_file.c
		ngx_module.c
		ngx_resolver.c
		ngx_open_file_cache.c
		ngx_crypt.c
		ngx_proxy_protocol.c
		ngx_syslog.c
	)
	event/(
		ngx_event.c
		ngx_event_timer.c
		ngx_event_posted.c
		ngx_event_accept.c
		ngx_event_udp.c
		ngx_event_connect.c
		ngx_event_pipe.c
		modules/ngx_epoll_module.c
	)
	http/ngx_http_file_cache.c
	os/unix/(
		ngx_time.c
		ngx_errno.c
		ngx_alloc.c
		ngx_files.c
		ngx_socket.c
		ngx_recv.c
		ngx_readv_chain.c
		ngx_udp_recv.c
		ngx_send.c
		ngx_writev_chain.c
		ngx_udp_send.c
		ngx_udp_sendmsg_chain.c
		ngx_channel.c
		ngx_shmem.c
		ngx_process.c
		ngx_daemon.c
		ngx_setaffinity.c
		ngx_setproctitle.c
		ngx_posix_init.c
		ngx_user.c
		ngx_dlopen.c
		ngx_process_cycle.c

		ngx_linux_init.c
		ngx_linux_sendfile_chain.c
	)
)]]
for line in iterlines('sources.txt') do
	local i = line:find(' ', 1, true)
	if modules[line:sub(1, i and i - 1)] then
		while i do
			local j = line:find(' ', i + 1, true)
			table.insert(sources, 'src/'..line:sub(i + 1, j and j - 1))
			i = j
		end
	end
end

exe('nginx', {sources, 'ngx_modules.c.o', libs})
file('bin/nginx', '755', '$outdir/nginx')
file('share/nginx/mime.types', '644', '$srcdir/conf/mime.types')

build('sed', '$outdir/nginx.8', '$srcdir/docs/man/nginx.8', {
	expr={
		'-e s,%%PREFIX%%,/run/nginx/,',
		'-e s,%%PID_PATH%%,/run/nginx/nginx.pid,',
		'-e s,%%CONF_PATH%%,/etc/nginx/nginx.conf,',
		'-e s,%%ERROR_LOG_PATH%%,/var/log/nginx/error.log,',
	},
})
man{'$outdir/nginx.8'}

fetch 'git'
