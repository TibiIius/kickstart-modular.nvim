local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  { src = gh '2giosangmitom/sqmeow.nvim' },
  { src = gh 'MunifTanjim/nui.nvim' },
}

require('sqmeow').setup()
