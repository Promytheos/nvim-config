local M = {}
local which_key = require("which-key")

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
            g = { desc = ' Git'}
        },
        opts = { prefix = '<leader>' }
    },
}

M.create_group = function(group_name, prefix)
    local group = {
        maps = {},
        opts = { prefix = prefix, desc = group_name }
    }
    table.insert(groups, group)
    return M.get_group(prefix)
end

M.get_group = function(prefix)
    for i = 1, #groups, 1 do
        local prefix_group = groups[i]
        if prefix_group.opts.prefix == prefix then
            return prefix_group
        end
    end
end

M.get_group_prefix =  function (group_name, prefix_name)
    local group = M.get_group(group_name).maps
    for prefix, opts in pairs(group) do
        if prefix == prefix_name then
            return opts
        end
    end
end


M.register_keymaps = function()
    for i = 1, #groups, 1 do
        local group = groups[i]
        which_key.register(group.maps, group.opts)
    end
end

M.register_key = function (key, command, opts)
    opts = opts or {}
    local desc = opts.desc or ""
    local mode = opts.mode or 'n'
    which_key.register({[key] = { command, desc }}, { mode = mode })
end

return M
