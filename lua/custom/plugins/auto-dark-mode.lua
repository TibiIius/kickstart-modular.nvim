return {
  {
    'f-person/auto-dark-mode.nvim',
    opts = {
      set_dark_mode = function()
        require('material.functions').change_style 'darker'
      end,
      set_light_mode = function()
        require('material.functions').change_style 'lighter'
      end,
      update_interval = 100,
      fallback = 'light',
    },
  },
}
