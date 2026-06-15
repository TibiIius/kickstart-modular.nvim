local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  { src = gh 'kristijanhusak/vim-dadbod-ui' },
  { src = gh 'tpope/vim-dadbod' },
  { src = gh 'kristijanhusak/vim-dadbod-completion' },
}

vim.g.db_ui_use_nerd_fonts = vim.g.have_nerd_font

-- vim: ts=2 sts=2 sw=2 et
