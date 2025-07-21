return {
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
    undo = {
    }
  }
}
