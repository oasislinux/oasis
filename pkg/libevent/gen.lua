cflags{
	'-I $dir',
	'-I $outdir/include',
	'-I $srcdir/include',
	'-I include',
	'-idirafter pkg/openbsd/src/sys',
}

build('sed', '$outdir/include/event2/event-config.h', {'$dir/config.h', '|', '$srcdir/make-event-config.sed'}, {
	expr='-f $srcdir/make-event-config.sed',
})

pkg.hdrs = {
	'$outdir/include/event2/event-config.h',
}
pkg.deps = {
	'$dir/headers',
	'$builddir/pkg/openbsd/fetch.stamp',
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
