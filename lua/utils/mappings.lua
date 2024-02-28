local M = {}
local whichKey = require("which-key")

local groups = {
    {
        maps = {
            f = { desc = " Find" },
            p = { desc = '󰏓 Manage Packages' },
            l = { desc = ' LSP' },
            u = { desc = ' UI' },
            b = { desc = '󰓩 Buffers' },
            d = { desc = ' Debugger' },
            t = { desc = ' Terminal' },
        },
        opts = { prefix = '<leader>' }
    },
}

M.createGroup = function(groupName, prefix)
    local group = {
        maps = {},
        opts = { prefix = prefix, desc = groupName }
    }
    table.insert(groups, group)
    return M.getGroup(prefix)
end

M.getGroup = function(prefix)
    for i = 1, #groups, 1 do
        local prefixGroup = groups[i]
        if prefixGroup.opts.prefix == prefix then
            return prefixGroup
        end
    end
end

M.getGroupPrefix =  function (groupName, prefixName)
    local group = M.getGroup(groupName).maps
    for prefix, opts in pairs(group) do
        if prefix == prefixName then
            return opts
        end
    end
end


M.registerKeymaps = function()
    for i = 1, #groups, 1 do
        local group = groups[i]
        whichKey.register(group.maps, group.opts)
    end
end

M.registerKey = function (key, command, opts)
    local desc = opts.desc or ""
    local mode = opts.mode or 'n'
    whichKey.register({[key] = { command, desc }}, { mode = mode })
end

return M
