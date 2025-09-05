return {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup {
    render = 'compact',
      stages = 'fade',
    }
  end,
}
