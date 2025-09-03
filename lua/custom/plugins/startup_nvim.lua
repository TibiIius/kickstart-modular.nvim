return {
  'startup-nvim/startup.nvim',
  version = '*',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    require('startup').setup { theme = 'dashboard' }
  end,
}
