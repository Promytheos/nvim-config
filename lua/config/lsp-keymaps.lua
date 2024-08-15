return {
  { 'K', vim.lsp.buf.hover, desc = 'Hover Documentation' },

  { "<leader>l", group = "LSP", icon = '󱁼' },
  { "<leader>lr", vim.lsp.buf.rename, desc = 'Rename', icon = '󰑕' },
  { "<leader>la", vim.lsp.buf.code_action, desc = 'Code Action' },
  { "<leader>lf", vim.lsp.buf.format, desc = 'Format Buffer' },
  { "<leader>lT", require('telescope.builtin').lsp_type_definitions, desc = 'Type Definition', icon = '' },
  { "<leader>ls", require('telescope.builtin').lsp_document_symbols, desc = 'Document Symbols', icon = '' },
  { "<leader>lw", require('telescope.builtin').lsp_dynamic_workspace_symbols, desc = 'Workspace Symbols', icon = '' },
  { "<leader>li", '<cmd>lua vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())<cr>', desc = 'Toggle Inlay Hints' },
  { "<leader>lI", '<cmd>LspInfo<cr>', desc = 'LSP Info', icon = "" },
  { "<leader>lh", vim.lsp.buf.signature_help, desc = 'Signature Help', icon = "󰋖" },
  { "<leader>ld", vim.diagnostic.open_float, desc = 'Open Diagnostics' },
  { "<leader>lq", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics", },
  { "<leader>lQ", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },

  { "g", group = "Go To" },
  { "gd", vim.lsp.buf.definition, desc = 'Goto Definition' },
  { "gr", require('telescope.builtin').lsp_references, desc = 'Goto References' },
  { "gI", require('telescope.builtin').lsp_implementations, desc = 'Goto Implementation' },
  { "gD", vim.lsp.buf.declaration, desc = 'Goto Declaration' },
  { "gj", vim.diagnostic.goto_next, desc = 'Goto Next Diagnostic' },
  { "gk", vim.diagnostic.goto_prev, desc = 'Goto Prev Diagnostic' },

  -- Trouble
  { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)", },
  { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
  { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)", },
  { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)", },
}
