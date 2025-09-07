return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      enabled = true,
    },
    picker = { enabled = true },
    explorer = { enabled = true },
    terminal = { enabled = true },
    lazygit = { configure = true },
  },

  config = function()
    Snacks.indent.enable()

    vim.keymap.set('n', '<leader>gl', function()
      Snacks.lazygit.open()
    end, { desc = '[L]azyGit' })

    vim.keymap.set('n', '<leader>jn', function()
      Snacks.terminal.open()
    end, { desc = '[N]ew terminal' })

    vim.keymap.set('n', '<leader>jf', function()
      Snacks.terminal.open 'zsh'
    end, { desc = '[F]loating terminal' })

    vim.keymap.set('n', '<leader>jt', function()
      Snacks.terminal.toggle()
    end, { desc = '[T]oggle terminal' })

    vim.keymap.set('n', '<leader>js', function()
      Snacks.terminal.list()
    end, { desc = '[S]elect open terminals' })

    vim.keymap.set('n', '<leader>bo', function()
      Snacks.explorer.open {
        layout = {
          layout = { position = 'right' },
        },
      }
    end, { desc = '[O]pen File [B]rowser' })

    vim.keymap.set('n', '<leader>br', function()
      Snacks.explorer.open {
        layout = {
          layout = { position = 'right' },
        },
      }
    end, { desc = '[R]eveal in File [B]rowser' })
  end,
}
