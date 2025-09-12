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
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    'refractalize/oil-git-status.nvim',
    dependencies = {
      { 'stevearc/oil.nvim', opts = {} },
    },
    opts = {},
  },
}
