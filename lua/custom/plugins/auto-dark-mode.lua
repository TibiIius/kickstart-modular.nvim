return {
  {
    'f-person/auto-dark-mode.nvim',
    opts = {
      set_dark_mode = function()
        require('visual_studio_code').setup {
          mode = 'dark',
        }
        vim.cmd.colorscheme 'visual_studio_code'
      end,
      set_light_mode = function()
        require('visual_studio_code').setup {
          mode = 'light',
        }
        vim.cmd.colorscheme 'visual_studio_code'
      end,
      update_interval = 100,
      fallback = 'light',
    },
  },
}
