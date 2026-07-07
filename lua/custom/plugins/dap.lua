local function gh(repo) return 'https://github.com/' .. repo end

-- DAP signs
local sign = vim.fn.sign_define
sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = 'DapBreakpointCondition', numhl = '' })
sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
sign('DapStopped', { text = '󰜴', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
sign('DapBreakpointRejected', { text = '', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })

vim.pack.add {
  { src = gh 'mfussenegger/nvim-dap' },
  { src = gh 'Joakker/lua-json5' },
  { src = gh 'mfussenegger/nvim-dap-python' },
  { src = gh 'leoluz/nvim-dap-go' },
  { src = gh 'igorlfs/nvim-dap-view', version = vim.version.range '1.*' },
  { src = gh 'nvim-neotest/nvim-nio' },
  { src = gh 'jay-babu/mason-nvim-dap.nvim' },
  { src = gh 'lucaSartore/nvim-dap-exception-breakpoints' },
}

-- nvim-dap
local dap = require 'dap'
local dap_python = require 'dap-python'
local dap_go = require 'dap-go'
dap_python.setup 'uv'
dap_go.setup()

require('dap.ext.vscode').json_decode = require('json5').parse

dap.adapters.codelldb = { type = 'executable', command = 'codelldb' }
dap.adapters.lldb = { type = 'executable', command = 'codelldb' }

vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = '[D]AP [T]erminate' })
vim.keymap.set('n', '<leader>dr', dap.restart, { desc = '[D]AP [R]estart' })
vim.keymap.set('n', '<leader>dn', ':DapNew<CR>', { desc = '[D]AP [N]ew' })
vim.keymap.set('n', '<leader>dso', ':DapStepOver<CR>', { desc = '[D]AP [S]tep [O]ver' })
vim.keymap.set('n', '<leader>dsu', ':DapStepOut<CR>', { desc = '[D]AP [S]tep O[u]t' })
vim.keymap.set('n', '<leader>dsi', ':DapStepInto<CR>', { desc = '[D]AP [S]tep [I]nto' })
vim.keymap.set('n', '<leader>dc', ':DapContinue<CR>', { desc = '[D]AP [C]ontinue' })
vim.keymap.set('n', '<leader>db', ':DapToggleBreakpoint<CR>', { desc = '[D]AP Toggle [B]reakpoint' })
vim.keymap.set('n', '<leader>dB', ':DapClearBreakpoints<CR>', { desc = '[D]AP Clear [B]reakpoints' })

-- nvim-dap-view
local dapui = require 'dap-view'
dapui.setup {
  winbar = {
    sections = { 'watches', 'scopes', 'exceptions', 'breakpoints', 'threads', 'repl', 'console' },
  },
  virtual_text = {
    enabled = true,
  },
}

vim.keymap.set('n', '<leader>tD', dapui.toggle, { desc = '[T]oggle [D]AP' })
vim.keymap.set('n', '<leader>dp', dapui.hover, { desc = '[D]AP [P]eek (Inline Evaluate)' })

-- mason-nvim-dap
require('mason-nvim-dap').setup {
  automatic_installation = true,
  ensure_installed = {},
}

-- exception breakpoints
vim.keymap.set('n', '<leader>de', require 'nvim-dap-exception-breakpoints', { desc = '[D]AP [E]xceptions' })

-- vim: ts=2 sts=2 sw=2 et
