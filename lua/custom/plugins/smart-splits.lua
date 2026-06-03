return {
  'mrjones2014/smart-splits.nvim',
  version = '>=1.0.0',
  opts = {},
  keys = {
    { '<c-h>', function() require('smart-splits').move_cursor_left() end },
    { '<c-j>', function() require('smart-splits').move_cursor_down() end },
    { '<c-k>', function() require('smart-splits').move_cursor_up() end },
    { '<c-l>', function() require('smart-splits').move_cursor_right() end },
    { '<c-\\>', function() require('smart-splits').move_cursor_previous() end },
  },
}
