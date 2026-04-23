return {
  'A7Lavinraj/fyler.nvim',
  dependencies = { 'nvim-mini/mini.nvim' },
  branch = 'stable',
  lazy = false, -- Necessary for `default_explorer` to work properly
  opts = {
    hooks = {
      on_rename = function(src_path, destination_path) Snacks.rename.on_rename_file(src_path, destination_path) end,
    },
    integrations = {
      winpick = 'builtin', -- or { provider = "none", opts = {} }
    },
    views = {
      finder = {
        close_on_select = false,
        follow_current_file = true,
      },
    },
  },
  keys = {
    {
      '<leader>ef',
      function()
        local fyler = require 'fyler'
        fyler.open { kind = 'split_right_most' }
      end,
      desc = 'Toggle Fyler',
    },
  },
}
