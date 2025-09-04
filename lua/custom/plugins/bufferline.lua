return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require 'bufferline'
    require('bufferline').setup {
      options = {
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, _, _)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
        show_buffer_close_icons = true,
        show_close_icon = true,
        always_show_bufferline = true,
        mode = 'buffers', -- set to "tabs" to only show tabpages instead
        style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
        themable = false, -- allows highlight groups to be overriden i.e. sets highlights as default
        numbers = 'none',
        close_command = 'bdelete! %d', -- can be a string | function, | false see "Mouse actions"
        middle_mouse_command = 'bdelete! %d', -- can be a string | function | false, see "Mouse actions"
        left_mouse_command = 'buffer %d', -- can be a string | function, | false see "Mouse actions"
        right_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
        indicator = {
          icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'icon',
        },
        buffer_close_icon = '󰅖',
        modified_icon = '● ',
        close_icon = ' ',
        left_trunc_marker = ' ',
        right_trunc_marker = ' ',
      },
    }
  end,
}
