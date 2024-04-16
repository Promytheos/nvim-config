return {
    options = {
        theme = "auto",
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter", "oil" } },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            {
                "branch",
                on_click = function()
                    vim.cmd("lua Lazygit_Toggle()")
                end
            }
        },
        lualine_c = {
            {
                "filetype",
                icon_only = true,
                separator = "",
                padding = { left = 1, right = 0 },
                on_click = function()
                    if (vim.bo.filetype ~= "lspinfo" and vim.bo.filetype ~= "toggleterm") then
                        vim.cmd(":LspInfo")
                    end
                end,
            },
            {
                "filename",
                on_click = function()
                    vim.cmd(":Oil")
                end
            },
            {
                "diagnostics",
            },
        },
        lualine_x = {
            -- stylua: ignore
            {
                function() return require("noice").api.status.command.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            },
            -- stylua: ignore
            {
                function() return require("noice").api.status.mode.get() end,
                cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            },
            -- stylua: ignore
            {
                function() return "  " .. require("dap").status() end,
                cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            },
            {
                require("lazy.status").updates,
                cond = require("lazy.status").has_updates,
            },
            {
                "diff",
                source = function()
                    local gitsigns = vim.b.gitsigns_status_dict
                    if gitsigns then
                        return {
                            added = gitsigns.added,
                            modified = gitsigns.changed,
                            removed = gitsigns.removed,
                        }
                    end
                end,
            },
        },
        lualine_y = {
            { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
            function()
                return "  " .. os.date("%R")
            end,
        },
    },
    extensions = { "neo-tree", "lazy" },
}
