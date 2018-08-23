local modules = {}
for m in pairs(dofile(arg[1])) do
	table.insert(modules, m)
end
table.sort(modules)

for line in io.lines() do
	if line == '/* -- ADDMODULE MARKER 1 -- */' then
		for _, m in ipairs(modules) do
			print('extern PyObject *PyInit_'..m..'(void);')
		end
	elseif line == '/* -- ADDMODULE MARKER 2 -- */' then
		for _, m in ipairs(modules) do
			print('    {"'..m..'", PyInit_'..m..'},')
		end
	else
		print(line)
	end
end
