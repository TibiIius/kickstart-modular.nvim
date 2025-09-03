-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>nt', ':Neotree reveal<CR>', desc = '[N]eo[T]ree', silent = true },
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
}
