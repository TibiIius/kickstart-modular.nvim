return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-mini/mini.nvim',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>en', ':Neotree<CR>', desc = '[E]xplore [N]eoTree', silent = true },
  },
  opts = {
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      filtered_items = {
        visible = true,
      },
      window = {
        position = 'right',
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
  config = function(_, opts)
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()

    require('neo-tree').setup(opts)
  end,
}
