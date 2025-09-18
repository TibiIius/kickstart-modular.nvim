return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'Joakker/lua-json5',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local dap = require 'dap'
      local dap_python = require 'dap-python'
      dap_python.setup 'uv'

      -- launch.json files can have comments etc, so we need json5
      require('dap.ext.vscode').json_decode = require('json5').parse

      vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = '[D]AP [T]erminate' })
      vim.keymap.set('n', '<leader>dr', dap.restart, { desc = '[D]AP [R]estart' })
      vim.keymap.set('n', '<leader>dn', ':DapNew<CR>', { desc = '[D]AP [N]ew' })
      vim.keymap.set('n', '<leader>dso', ':DapStepOver<CR>', { desc = '[D]AP [S]tep [O]ver' })
      vim.keymap.set('n', '<leader>dsu', ':DapStepOut<CR>', { desc = '[D]AP [S]tep O[u]t' })
      vim.keymap.set('n', '<leader>dsi', ':DapStepInto<CR>', { desc = '[D]AP [S]tep [I]nto' })
      vim.keymap.set('n', '<leader>dc', ':DapContinue<CR>', { desc = '[D]AP [C]ontinue' })
      vim.keymap.set('n', '<leader>db', ':DapToggleBreakpoint<CR>', { desc = '[D]AP Toggle [B]reakpoint' })
      vim.keymap.set('n', '<leader>dB', ':DapClearBreakpoints<CR>', { desc = '[D]AP Clear [B]reakpoints' })

      dap.adapters.codelldb = {
        type = 'executable',
        command = 'codelldb',

        -- On windows you may have to uncomment this:
        -- detached = false,
      }

      dap.adapters.lldb = {
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

      dapui.setup()

      vim.keymap.set('n', '<leader>td', dapui.toggle, { desc = '[T]oggle [D]AP' })
      vim.keymap.set('n', '<leader>dp', dapui.eval, { desc = '[D]AP [P]eek (Inline Evaluate)' })

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
