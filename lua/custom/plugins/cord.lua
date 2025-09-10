return {
  'vyfor/cord.nvim',
  build = ':Cord update',
  opts = {
    editor = {
      tooltip = 'WaifuVim',
      plugins = {
        'cord.plugins.diagnostics', -- Enable the diagnostics plugin
      },
    },
  },
}
