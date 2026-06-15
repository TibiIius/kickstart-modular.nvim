local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'akinsho/git-conflict.nvim' } }

pcall(function() require('git-conflict').setup {} end)

-- vim: ts=2 sts=2 sw=2 et
