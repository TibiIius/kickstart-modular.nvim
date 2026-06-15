local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'MeanderingProgrammer/render-markdown.nvim' } }

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('render-markdown').setup {
  completions = {
    blink = { enabled = true },
  },
}

-- vim: ts=2 sts=2 sw=2 et
