local function probe(var)
	build('probe', '$outdir/'..var, {'$dir/'..var, '|', '$basedir/scripts/probe.sh'}, {var=var})
end

probe('HAVE_EMMINTRIN_H')
probe('HAVE_IMMINTRIN_H')
probe('HAVE_INLINE_ASM')
probe('HAVE_MMINTRIN_H')
probe('HAVE__MM_MOVEMASK_EPI8')
probe('HAVE__THREAD_LOCAL')
probe('HAVE___BUILTIN_ASSUME_ALIGNED')
probe('HAVE___BUILTIN_CHOOSE_EXPR')
probe('HAVE___BUILTIN_CLZ')
probe('HAVE___BUILTIN_CTZL')
probe('HAVE___BUILTIN_POPCOUNT')
probe('PIC')

local function probesize(var)
	build('probe-size', '$outdir/'..var, {'$dir/'..var, '|', '$basedir/scripts/probe-size.sh'}, {var=var})
end

probesize('SIZEOF_LONG')
probesize('SIZEOF_SIZE_T')
probesize('SIZEOF_TIME_T')
