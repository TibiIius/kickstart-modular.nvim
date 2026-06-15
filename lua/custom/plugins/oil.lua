local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  { src = gh 'stevearc/oil.nvim' },
  { src = gh 'refractalize/oil-git-status.nvim' },
}

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('oil').setup {
  default_file_explorer = true,
  columns = { 'icon' },
  buf_options = { buflisted = true },
  view_options = { show_hidden = true },
  win_options = { signcolumn = 'yes:2' },
}

vim.keymap.set('n', '<leader>eo', '<cmd>Oil<cr>', { desc = '[E]xplore [O]il' })

-- vim: ts=2 sts=2 sw=2 et
