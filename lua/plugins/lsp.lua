return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "stevearc/conform.nvim",
    },
    config = function()
      local servers = {
        bashls = true,
        gopls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = { enable = true }
    }
  },
  ts_ls = {
    hostInfo = "neovim",
    preferences = {
      quotePreference = 'single',
      includeCompletionsForModuleExports = true,
      includeCompletionsForImportStatements = true,
      importModuleSpecifierPreference = 'non-relative',
      importModuleSpecifierEnding = 'minimal',
    },
    typescript = {
      codeActionsOnSave = {
        source = {
          organizeImports = true,
          fixAll = true,
          addMissingImports = true
        }
      },
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
  }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local c = vim.lsp.get_client_by_id(args.data.client_id)
          if not c then return end

          if vim.bo.filetype == "lua" then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
              end,
            })
          end
        end,
      })
    end
  },
}
