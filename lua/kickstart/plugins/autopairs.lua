-- autopairs
-- https://github.com/windwp/nvim-autopairs

vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }
require('nvim-autopairs').setup {}

-- Lazy load on InsertEnter
vim.api.nvim_create_autocmd('InsertEnter', {
  group = vim.api.nvim_create_augroup('autopairs-load', { clear = true }),
  callback = function()
    pcall(require, 'nvim-autopairs')
  end,
})

-- vim: ts=2 sts=2 sw=2 et
