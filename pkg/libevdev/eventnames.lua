local duplicates = {
	EV_VERSION=true,
	BTN_MISC=true,
	BTN_MOUSE=true,
	BTN_JOYSTICK=true,
	BTN_GAMEPAD=true,
	BTN_DIGI=true,
	BTN_WHEEL=true,
	BTN_TRIGGER_HAPPY=true,
	SW_MAX=true,
	REP_MAX=true,
	FF_STATUS_MAX=true,
}

local skip = {
	BTN=true,
	EV=true,
	INPUT_PROP=true,
	MT_TOOL=true,
}

local prefixes = {
	'EV',
	'REL',
	'ABS',
	'KEY',
	'BTN',
	'LED',
	'SND',
	'MSC',
	'SW',
	'FF',
	'SYN',
	'REP',
	'INPUT_PROP',
	'MT_TOOL',
}

local bits = {}
for _, prefix in ipairs(prefixes) do
	bits[prefix] = {}
end
bits.EV.map = {}

local function lookuptable(prefix)
	local entries = {}
	for _, name in ipairs(bits[prefix]) do
		table.insert(entries, name)
	end
	local max = prefix..'_MAX'
	if duplicates[max] then
		table.insert(entries, max)
	end
	table.sort(entries)
	for _, name in ipairs(entries) do
		io.write(string.format('    { .name = "%s", .value = %s },\n', name, name))
	end
end

for i = 1, #arg do
	for line in io.lines(arg[i]) do
		local name, value = line:match('^#define%s+(%g+)%s+([%xx]+)%f[^%g]')
		value = tonumber(value)
		if name and not duplicates[name] then
			for prefix, b in pairs(bits) do
				if name:sub(1, #prefix + 1) == prefix..'_' then
					if b.map then
						b.map[value] = name
						b.map[name] = value
					end
					table.insert(b, name)
				end
			end
		end
	end
end

io.write[[
/* THIS FILE IS GENERATED, DO NOT EDIT */

#ifndef EVENT_NAMES_H
#define EVENT_NAMES_H

]]
for _, prefix in ipairs(prefixes) do
	if prefix ~= 'BTN' then
		io.write(string.format('static const char * const %s_map[%s_MAX + 1] = {\n', prefix:lower(), prefix))
		for _, name in ipairs(bits[prefix]) do
			io.write(string.format('    [%s] = "%s",\n', name, name))
		end
		if prefix == 'KEY' then
			for _, name in ipairs(bits.BTN) do
				io.write(string.format('    [%s] = "%s",\n', name, name))
			end
		end
		io.write[[
};

]]
	end
end
for _, name in ipairs{'BTN_A', 'BTN_B', 'BTN_X', 'BTN_Y'} do
	table.insert(bits.BTN, name)
end
io.write[[
static const char * const * const event_type_map[EV_MAX + 1] = {
]]
for _, prefix in ipairs(prefixes) do
	if not skip[prefix] then
		print(string.format('    [EV_%s] = %s_map,', prefix, prefix:lower()))
	end
end
io.write[[
};

#if __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winitializer-overrides"
#elif __GNUC__
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Woverride-init"
#endif
static const int ev_max[EV_MAX + 1] = {
]]
for i = 0, bits.EV.map.EV_MAX do
	local name = bits.EV.map[i]
	if name and bits[name:sub(4)] then
		io.write(string.format('    %s_MAX,\n', name:sub(4)))
	else
		io.write('    -1,\n')
	end
end
io.write[[
};
#if __clang__
#pragma clang diagnostic pop /* "-Winitializer-overrides" */
#elif __GNUC__
#pragma GCC diagnostic pop /* "-Woverride-init" */
#endif

struct name_entry {
    const char *name;
    unsigned int value;
};

static const struct name_entry tool_type_names[] = {
]]
lookuptable('MT_TOOL')
io.write[[
};

static const struct name_entry ev_names[] = {
]]
lookuptable('EV')
io.write[[
};

static const struct name_entry code_names[] = {
]]
lookuptable('ABS')
lookuptable('BTN')
lookuptable('FF')
lookuptable('KEY')
lookuptable('LED')
lookuptable('MSC')
lookuptable('REL')
lookuptable('REP')
lookuptable('SND')
lookuptable('SW')
lookuptable('SYN')
io.write[[
};

static const struct name_entry prop_names[] = {
]]
lookuptable('INPUT_PROP')
io.write[[
};

#endif /* EVENT_NAMES_H */
]]
