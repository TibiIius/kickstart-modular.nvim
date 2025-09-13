return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-mini/mini.nvim',
  }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  configure = function()
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()

    require('render-markdown').setup {
      completions = {
        blink = { enabled = true },
      },
    }
  end,
}
