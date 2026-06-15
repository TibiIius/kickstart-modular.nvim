local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'smjonas/inc-rename.nvim' } }

pcall(require, 'inc-rename')

-- vim: ts=2 sts=2 sw=2 et
