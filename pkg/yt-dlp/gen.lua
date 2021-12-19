file('bin/yt-dlp', '755', '$dir/yt-dlp')
for f in iterlines('pylibs.txt') do
	file('lib/python3.10/'..f, '644', '$srcdir/'..f)
end
man{'yt-dlp.1'}

fetch 'curl'
