local optionshdr = arg[1]
local type = arg[2]
local var = arg[3]

local options = {}
for line in io.lines(optionshdr) do
	local cfg, val = line:match('^#define CONFIG_(%g+) (%g+)$')
	if cfg then
		options[cfg] = val == '1'
	end
end

print('static const '..type..' *const '..var..'[] = {')
for line in io.lines() do
	local name = line:match('^extern .*'..type..' +ff_(%g+);$')
	if name then
		local cfg
		if var == 'filter_list' then
			local i = name:find('_', 1, true)
			if i then
				cfg = name:sub(i + 1)..'_filter'
			end
		elseif var == 'outdev_list' then
			if name:sub(-6) == '_muxer' then
				cfg = name:sub(1, -7)..'_outdev'
			end
		elseif var == 'indev_list' then
			if name:sub(-8) == '_demuxer' then
				cfg = name:sub(1, -9)..'_indev'
			end
		else
			cfg = name
		end
		if cfg and options[cfg:upper()] then
			print('&ff_'..name..',')
		end
	end
end
if var == 'filter_list' then
	print('&ff_asrc_abuffer,')
	print('&ff_vsrc_buffer,')
	print('&ff_asink_abuffer,')
	print('&ff_vsink_buffer,')
end
print('NULL};')
