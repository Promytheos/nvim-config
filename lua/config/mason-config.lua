local servers = {
        lua_ls = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                hint = { enable = true }
            }
        },
}
local capabilities = {}
return {
    ensure_installed = vim.tbl_keys(servers),
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                on_attach = require("config.lsp-keymaps").register_lsp_keymaps,
                settings = servers[server_name],
                filetypes = (servers[server_name] or {}).filetypes,
            }
        end,
        ['jdtls'] = function()
        end,
        ['tsserver'] = function()
        end,
    }
}
