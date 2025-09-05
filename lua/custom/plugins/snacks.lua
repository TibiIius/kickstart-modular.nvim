return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      scope = {
        treesitter = {
          enabled = true,
        },
      },
    },
    terminal = { enabled = true },
    lazygit = { configure = true },
  },

  config = function()
    local snacks = require 'snacks'

    vim.keymap.set('n', '<leader>l', function()
      snacks.lazygit.open()
    end, { desc = '[L]azyGit' })

    vim.keymap.set('n', '<leader>jn', function()
      snacks.terminal.open()
    end, { desc = '[N]ew terminal' })
    vim.keymap.set('n', '<leader>jf', function()
      snacks.terminal.open 'zsh'
    end, { desc = '[F]loating terminal' })
    vim.keymap.set('n', '<leader>jt', function()
      snacks.terminal.toggle()
    end, { desc = '[T]oggle terminal' })
    vim.keymap.set('n', '<leader>js', function()
      snacks.terminal.list()
    end, { desc = '[S]elect open terminals' })
  end,
}
