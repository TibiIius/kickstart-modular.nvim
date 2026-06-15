local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'chrisgrieser/nvim-origami' } }

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

require('origami').setup {}

-- vim: ts=2 sts=2 sw=2 et
