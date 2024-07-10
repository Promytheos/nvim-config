return {
  integrations = {
    cmp = true,
    gitsigns = true,
    treesitter = true,
    mini = {
      enabled = true,
    }
  },
  custom_highlights = function(colors)
    return {
      WinSeparator = { fg = colors.teal }
    }
  end
}
