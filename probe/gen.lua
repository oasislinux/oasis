local function probe(var)
	build('probe', '$outdir/'..var, '$dir/'..var, {var=var})
end
