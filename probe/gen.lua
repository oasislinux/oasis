local function probe(var)
	build('probe', '$outdir/'..var, '$dir/'..var, {var=var})
end

probe('HAVE_IMMINTRIN_H')
probe('HAVE__MM_MOVEMASK_EPI8')
