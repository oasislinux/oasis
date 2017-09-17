for f in iterlines('fonts.txt') do
	file('share/plan9/fonts/'..f, '644', '$srcdir/'..f)
end

fetch 'git'
