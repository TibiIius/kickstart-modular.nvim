-- return {
--   -- amongst your other plugins
--   {
--     'akinsho/toggleterm.nvim',
--     --    version = '*',
--     config = function()
--       require('toggleterm').setup {
--         open_mapping = '<leader>jt',
--         direction = 'horizontal',
--       }
--       local Terminal = require('toggleterm.terminal').Terminal
--       local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float', close_on_exit = true }
--
--       function _lazygit_toggle()
--         lazygit:toggle()
--       end
--
--       vim.api.nvim_set_keymap('n', '<leader>jg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true, desc = 'LazyGit Terminal' })
--       vim.api.nvim_set_keymap('n', '<leader>jn', Terminal:new {}, { noremap = true, silent = true, desc = 'New Terminal' })
--     end,
--   },
-- }
table.unpack = table.unpack or unpack
--
return {
  'waiting-for-dev/ergoterm.nvim',
  config = function()
    require('ergoterm').setup {
      terminal_defaults = {
        shell = vim.o.shell,
        layout = 'left',
      },
    }
    local terms = require 'ergoterm.terminal'

    -- Create standalone terminals
    local lazygit = terms.Terminal:new {
      name = 'lazygit',
      cmd = 'lazygit',
      layout = 'float',
      dir = 'git_dir',
      selectable = false,
      hidden = true,
      close_on_job_exit = true,
    }

    local opts = { noremap = true, silent = true }

    vim.keymap.set('n', '<leader>jg', function()
      lazygit:toggle()
    end, { desc = 'Lazy[G]it terminal', table.unpack(opts) })

    vim.keymap.set('n', '<leader>jn', ':TermNew layout=left<CR>', { desc = '[N]ew terminal', table.unpack(opts) })
    vim.keymap.set('n', '<leader>jf', ':TermNew layout=float<CR>', { desc = '[F]loating terminal', table.unpack(opts) })
    vim.keymap.set('n', '<leader>js', ':TermSelect<CR>', { desc = '[S]elect open terminals', table.unpack(opts) })
  end,
}
