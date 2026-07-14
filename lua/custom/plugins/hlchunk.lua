local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'shellRaining/hlchunk.nvim' }
require('hlchunk').setup {
  chunk = {
    enable = true,
  },
  line_num = {
    enable = true,
  },
}

local grp = vim.api.nvim_create_augroup('hlchunk-load', { clear = true })

local callbackfunc = function() pcall(require, 'hlchunk') end

vim.api.nvim_create_autocmd('BufReadPre', {
  group = grp,
  callback = callbackfunc,
})

vim.api.nvim_create_autocmd('BufNewFile', {
  group = grp,
  callback = callbackfunc,
})
