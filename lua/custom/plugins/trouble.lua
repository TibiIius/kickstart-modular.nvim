local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'folke/trouble.nvim' } }

vim.keymap.set('n', '<leader>lx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>lX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>ls', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })

-- vim: ts=2 sts=2 sw=2 et
