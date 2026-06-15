local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'vyfor/cord.nvim' } }

require('cord').setup {
  editor = {
    tooltip = 'WaifuVim',
    plugins = { 'cord.plugins.diagnostics' },
  },
}

-- vim: ts=2 sts=2 sw=2 et
