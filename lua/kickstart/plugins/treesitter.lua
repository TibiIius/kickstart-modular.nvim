local function gh(repo) return 'https://github.com/' .. repo end

-- [[ Configure Treesitter ]]
--  Used to highlight, edit, and navigate code
--
--  See `:help nvim-treesitter-intro`

vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter' } }

local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }

require('nvim-treesitter').setup {
  ensure_installed = parsers,
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
}

-- vim: ts=2 sts=2 sw=2 et
