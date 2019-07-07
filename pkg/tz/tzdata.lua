dofile 'ninja.lua'
config = dofile 'config.lua'

local function execute(cmd)
	if not os.execute(cmd) then
		error('command failed: '..cmd)
	end
end

local hash = 'sh ./scripts/hash.sh %s %s share/zoneinfo/%s %s'
local repo = arg[1]
local outdir = arg[2]
for i = 3, #arg do
	execute(string.format('zic -d %s %s', outdir, arg[i]))
	for line in io.lines(arg[i]) do
		local target, name = line:match('^Link%s+(%g+)%s+(%g+)')
		if target and fs('tz', 'share/zoneinfo/'..name) then
			target = name:gsub('[^/]+', '..'):sub(1, -3)..target
			execute(hash:format(repo, 120000, name, target))
		else
			name = line:match('^Zone%s+(%g+)')
			if name and fs('tz', 'share/zoneinfo/'..name) then
				execute(hash:format(repo, 100644, name, outdir..'/'..name))
			end
		end
	end
end
