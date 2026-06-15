local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'mrjones2014/smart-splits.nvim' } }

require('smart-splits').setup {}

vim.keymap.set('n', '<c-h>', function() require('smart-splits').move_cursor_left() end)
vim.keymap.set('n', '<c-j>', function() require('smart-splits').move_cursor_down() end)
vim.keymap.set('n', '<c-k>', function() require('smart-splits').move_cursor_up() end)
vim.keymap.set('n', '<c-l>', function() require('smart-splits').move_cursor_right() end)
vim.keymap.set('n', '<c-\\>', function() require('smart-splits').move_cursor_previous() end)

-- vim: ts=2 sts=2 sw=2 et
