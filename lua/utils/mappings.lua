local M = {}
local map = {}

local groups = {
	f = { desc = " Find" },
	p = { desc = '󰏓 Manage Packages' },
	l = { desc = ' LSP' },
	u = { desc = ' UI' },
	b = { desc = '󰓩 Buffers' },
	d = { desc = ' Debugger' },
	t = { desc = ' Terminal' },
}

M.setGroup = function(key, desc)
	desc = desc or 'prefix'
	if groups[key] == nil then
		groups[key] = { desc = desc }
	end
	return groups[key]
end

M.setLeaderGroup = function (key)
	if map[key] == nil then
		map[key] = {}
	end
	return map[key]
end

M.setMappings = function(keymap)
	map = keymap
end

M.registerKeymaps = function()
	require("which-key").register(map)
end

return M
