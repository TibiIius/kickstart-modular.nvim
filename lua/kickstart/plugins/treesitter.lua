local function gh(repo) return 'https://github.com/' .. repo end

-- [[ Configure Treesitter ]]
--  Used to highlight, edit, and navigate code
--
--  See `:help nvim-treesitter-intro`

vim.pack.add { { src = gh 'romus204/tree-sitter-manager.nvim' } }

require('tree-sitter-manager').setup {
  auto_install = true,
}

-- vim: ts=2 sts=2 sw=2 et
