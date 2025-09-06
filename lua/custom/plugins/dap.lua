return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'

      dap.adapters.codelldb = {
        type = 'executable',
        command = 'codelldb',

        -- On windows you may have to uncomment this:
        -- detached = false,
      }
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      local map = function(keys, func, desc, mode)
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'DAP: ' .. desc })
      end

      vim.keymap.set('n', '<leader>dr', dapui.toggle, { desc = '[D]AP [R]eveal' })

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'mason-org/mason.nvim', 'mfussenegger/nvim-dap' },
    config = function()
      require('mason-nvim-dap').setup {
        automatic_installation = true,
        ensure_installed = {},
      }
    end,
  },
  {
    'lucaSartore/nvim-dap-exception-breakpoints',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      local set_exception_breakpoints = require 'nvim-dap-exception-breakpoints'
      vim.keymap.set('n', '<leader>de', set_exception_breakpoints, { desc = '[D]AP [E]xceptions' })
    end,
  },
}
