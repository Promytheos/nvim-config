local M = {}
local map = {}


M.setMappings = function (keymap)
	map = keymap
end

M.registerKeymaps = function ()
	require("which-key").register(map)
end

return M
