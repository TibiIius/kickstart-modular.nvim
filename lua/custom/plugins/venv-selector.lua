local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  { src = gh 'linux-cultist/venv-selector.nvim' },
  { src = gh 'nvim-telescope/telescope.nvim', branch = '0.1.x' },
  { src = gh 'nvim-lua/plenary.nvim' },
}

pcall(function()
  require('venv-selector').setup {
    search = {},
    options = {},
  }
end)

vim.keymap.set('n', '<leader>Nv', '<cmd>VenvSelect<cr>', { desc = 'Select Python venv' })

-- vim: ts=2 sts=2 sw=2 et
