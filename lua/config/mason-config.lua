local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = { enable = true }
    }
  },
}

local init_options = {
  ts_ls = {
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
  ensure_installed = vim.tbl_keys(servers),
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = require("config.lsp-keymaps").register_lsp_keymaps,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
        init_options = init_options[server_name] or {}
      }
    end,
    ['jdtls'] = function()
    end,
  }
}
