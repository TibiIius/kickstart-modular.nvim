return {
  'Bekaboo/dropbar.nvim',
  depdendencies = { 'nvim-mini/mini.nvim' },
  config = function()
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()

    local dropbar_api = require 'dropbar.api'
    vim.keymap.set('n', '<leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
    vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
    vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
  end,
}
