BEGIN {
	while (getline < sources) {
		if ($0 ~ /^(#|$)/)
			continue
		all_modules[++n] = $1
	}

	enabled["core"] = 1
	enabled["errlog"] = 1
	enabled["conf"] = 1

	enabled["events"] = 1
	enabled["event_core"] = 1
	enabled["epoll"] = 1
}

/^(#|$)/ { next }
{
	enabled[$0] = 1
}

END {
	for (i = 1; i <= n; ++i) {
		module = all_modules[i]
		if (enabled[module])
			modules[++m] = module
	}

	print "#include <ngx_config.h>"
	print "#include <ngx_core.h>"

	for (i = 1; i <= m; ++i)
		print "extern ngx_module_t ngx_" modules[i] "_module;"

	print "ngx_module_t *ngx_modules[] = {"
	for (i = 1; i <= m; ++i)
			print "\t&ngx_" modules[i] "_module,"
	print "\tNULL"
	print "};"

	print "char *ngx_module_names[] = {"
	for (i = 1; i <= m; ++i)
		print "\t\"ngx_" modules[i] "_module\","
	print "\tNULL"
	print "};"
}
