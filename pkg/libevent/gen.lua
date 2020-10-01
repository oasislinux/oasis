cflags{
	'-I $dir',
	'-I $outdir/include',
	'-I $srcdir/include',
	'-isystem $builddir/pkg/openbsd/include',
}

build('sed', '$outdir/include/event2/event-config.h', {'$dir/config.h', '|', '$srcdir/make-event-config.sed'}, {
	expr='-f $srcdir/make-event-config.sed',
})

pkg.hdrs = {
	copy('$outdir/include/event2', '$srcdir/include/event2', {
		'buffer.h',
		'bufferevent.h',
		'dns.h',
		'event.h',
		'http.h',
		'http_struct.h',
		'util.h',
		'visibility.h',
	}),
	'$outdir/include/event2/event-config.h',
}
pkg.deps = {
	'$gendir/headers',
	'pkg/openbsd/headers',
}

lib('libevent.a', {
	'buffer.c',
	'bufferevent.c',
	'bufferevent_filter.c',
	'bufferevent_pair.c',
	'bufferevent_ratelim.c',
	'bufferevent_sock.c',
	'event.c',
	'evmap.c',
	'evthread.c',
	'evutil.c',
	'evutil_rand.c',
	'evutil_time.c',
	'listener.c',
	'log.c',

	'evdns.c',
	'event_tagging.c',
	'evrpc.c',
	'http.c',

	'epoll.c',
	'signal.c',
})

fetch 'git'
