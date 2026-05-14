/^(#|$)/ { next }
{
	modules[++m] = $0
}

END {
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
