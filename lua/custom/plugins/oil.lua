return {
  {
    'stevearc/oil.nvim',
    dependencies = {
      -- For mini.icons
      { 'nvim-mini/mini.nvim', opts = {} },
    },
    keys = {
      {
        '<leader>eo',
        '<cmd>Oil<cr>',
        desc = '[E]xplore [O]il',
      },
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      columns = {
        'icon',
      },
      buf_options = {
        buflisted = true,
      },
      view_options = {
        show_hidden = true,
      },
      win_options = {
        signcolumn = 'yes:2',
      },
    },
    lazy = false,

    config = function(_, opts)
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()

      require('oil').setup(opts)
    end,
  },
  {
    'refractalize/oil-git-status.nvim',
    dependencies = {
      { 'stevearc/oil.nvim', opts = {} },
    },
    opts = {},
  },
}
