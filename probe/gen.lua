local function probe(var)
	build('probe', '$outdir/'..var, {'$dir/'..var, '|', 'scripts/probe.sh'}, {var=var})
end

probe('HAVE_IMMINTRIN_H')
probe('HAVE__MM_MOVEMASK_EPI8')
probe('HAVE__THREAD_LOCAL')
probe('HAVE___BUILTIN_CLZ')
probe('HAVE___BUILTIN_CTZL')
probe('HAVE___BUILTIN_POPCOUNT')

local function probesize(var)
	build('probesize', '$outdir/'..var, {'$dir/'..var, '|', 'scripts/probe-size.sh'}, {var=var})
end

probesize('SIZEOF_LONG')
probesize('SIZEOF_SIZE_T')
probesize('SIZEOF_TIME_T')
