return {
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-mini/mini.nvim',
  },
  opts = {},
  keys = {
    { '<leader>Ss', '<cmd>lua require("spectre").toggle()<CR>', desc = '[S]pectre [S]earch' },
    { '<leader>Sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = '[S]pectre [W]ord', mode = 'n' },
    { '<leader>Sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = '[S]pectre [W]ord', mode = 'v' },
    { '<leader>Sc', '<cmd>lua require("spectre").open_file_search()<CR>', desc = '[S]pectre [C]urrent' },
    { '<leader>SC', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = '[S]pectre [C]urrent (select word)' },
  },
}
