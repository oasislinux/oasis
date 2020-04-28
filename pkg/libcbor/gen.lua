cflags{
	'-Wall', '-Wpedantic',
	'-D HAVE_ENDIAN_H',
	'-I $outdir/include',
}

build('sed', '$outdir/include/cbor/configuration.h', '$srcdir/src/cbor/configuration.h.in', {
	expr={
		[[-e 's,$${CBOR_VERSION_MAJOR},0,']],
		[[-e 's,$${CBOR_VERSION_MINOR},7,']],
		[[-e 's,$${CBOR_VERSION_PATCH},0,']],
		[[-e 's,$${CBOR_BUFFER_GROWTH},2,']],
		[[-e 's,$${CBOR_MAX_STACK_SIZE},2048,']],
		[[-e 's,$${CBOR_RESTRICT_SPECIFIER},restrict,']],
		[[-e 's,$${CBOR_INLINE_SPECIFIER},inline,']],
		'-e /CBOR_CUSTOM_ALLOC/d',
		'-e /CBOR_PRETTY_PRINTER/d',
	},
})

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/src', {
		'cbor.h',
		'cbor/arrays.h',
		'cbor/bytestrings.h',
		'cbor/callbacks.h',
		'cbor/common.h',
		'cbor/data.h',
		'cbor/encoding.h',
		'cbor/floats_ctrls.h',
		'cbor/ints.h',
		'cbor/maps.h',
		'cbor/serialization.h',
		'cbor/streaming.h',
		'cbor/strings.h',
		'cbor/tags.h',
	}),
	'$outdir/include/cbor/configuration.h',
}
pkg.deps = {'$gendir/headers'}

lib('libcbor.a', [[
	src/cbor.c
	src/cbor/(
		streaming.c
		internal/(
			encoders.c
			builder_callbacks.c
			loaders.c
			memory_utils.c
			stack.c
			unicode.c
		)
		encoding.c
		serialization.c
		arrays.c
		common.c
		floats_ctrls.c
		bytestrings.c
		callbacks.c
		strings.c
		maps.c
		tags.c
		ints.c
	)
]])

fetch 'git'
