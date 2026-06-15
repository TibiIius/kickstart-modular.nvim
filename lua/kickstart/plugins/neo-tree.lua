-- Neo-tree is a Neovim plugin to browse the file system
vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

vim.keymap.set('n', '<leader>en', ':Neotree<CR>', { desc = '[E]xplore [N]eoTree', silent = true })

require('neo-tree').setup {
  filesystem = {
    follow_current_file = { enabled = true },
    filtered_items = { visible = true },
    window = {
      position = 'right',
      mappings = { ['\\'] = 'close_window' },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
