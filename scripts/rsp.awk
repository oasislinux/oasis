function line() {
	if (match($0, /\.d$/))
		read($0)
	else
		libs[++n] = $0
}

function read(name) {
	for (;;) {
		ret = getline < name
		if (ret < 0) {
			print "failed to read line from " name > "/proc/self/fd/2"
			exit(1)
		}
		if (ret == 0)
			break
		line()
	}
	close(name)
}

{line()}

END {
	for (i = n; i > 0; --i) {
		lib = libs[i]
		if (lib in seen)
			continue
		seen[lib] = 1
		uniq[++m] = lib
	}
	for (i = m; i > 0; --i)
		print uniq[i]
}
