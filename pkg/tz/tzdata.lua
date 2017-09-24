local cmd = 'rc ./scripts/hash.rc %s %s share/zoneinfo/%s %s'

repo = arg[1]
outdir = arg[2]
for i = 3, #arg do
	for line in io.lines(arg[i]) do
		local target, name = line:match('^Link%s+(%g+)%s+(%g+)')
		if target then
			target = name:gsub('[^/]+', '..'):sub(1, -3)..target
			os.execute(cmd:format(repo, 120000, name, target))
		else
			name = line:match('^Zone%s+(%g+)')
			if name then
				os.execute(cmd:format(repo, 100644, name, outdir..'/'..name))
			end
		end
	end
end
