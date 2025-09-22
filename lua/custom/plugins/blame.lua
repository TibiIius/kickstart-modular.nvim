return {
  {
    'FabijanZulj/blame.nvim',
    lazy = false,
    keys = {
      { '<leader>tb', '<cmd>BlameToggle window<CR>', desc = '[T]oggle [B]lame (window)' },
    },
    opts = {
      virtual_style = 'float',
    },
    config = function(_, opts)
      require('blame').setup(opts)
    end,
  },
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>tB', '<cmd>GitBlameToggle<CR>', desc = '[T]oggle [B]lame' },
    },
    opts = {
      -- your configuration comes here
      -- for example
      enabled = true, -- if you want to enable the plugin
      message_template = '<sha> • <date> • <author> • <summary>', -- template for the blame message, check the Message template section for more options
      date_format = '%m-%d-%Y %H:%M:%S', -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    },
  },
}
