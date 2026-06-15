local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'akinsho/bufferline.nvim' } }

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('bufferline').setup {
  options = {
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level)
      local icon = level:match 'error' and ' ' or ' '
      return ' ' .. icon .. count
    end,
    show_buffer_close_icons = true,
    show_close_icon = true,
    always_show_bufferline = false,
    mode = 'tabs',
    style_preset = require('bufferline').style_preset.default,
    themable = false,
    numbers = 'none',
    close_command = 'bdelete! %d',
    middle_mouse_command = 'bdelete! %d',
    left_mouse_command = 'buffer %d',
    right_mouse_command = nil,
    indicator = { icon = '▎', style = 'icon' },
    buffer_close_icon = '󰅖',
    modified_icon = '● ',
    close_icon = ' ',
    left_trunc_marker = ' ',
    right_trunc_marker = ' ',
  },
}

-- vim: ts=2 sts=2 sw=2 et
