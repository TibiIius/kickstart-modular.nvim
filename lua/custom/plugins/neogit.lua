local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  { src = gh 'NeogitOrg/neogit' },
  { src = gh 'nvim-lua/plenary.nvim' },
  { src = gh 'sindrets/diffview.nvim' },
}

vim.keymap.set('n', '<leader>gs', '<cmd>Neogit<cr>', { desc = '[G]it [S]tatus' })

-- vim: ts=2 sts=2 sw=2 et
