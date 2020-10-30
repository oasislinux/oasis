file('bin/youtube-dl', '755', '$srcdir/bin/youtube-dl')
for f in iterlines('pylibs.txt') do
	file('lib/python3.9/'..f, '644', '$srcdir/'..f)
end

fetch 'curl'
