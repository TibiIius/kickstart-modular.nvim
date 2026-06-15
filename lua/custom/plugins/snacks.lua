local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'folke/snacks.nvim' } }

local snacks = require 'snacks'
snacks.setup {
  styles = {
    zen = {
      enter = true,
      fixbuf = false,
      minimal = false,
      width = 240,
      height = 0,
      backdrop = { transparent = true, blend = 40 },
      keys = { q = false },
      zindex = 40,
      wo = { winhighlight = 'NormalFloat:Normal' },
      w = { snacks_main = true },
    },
  },
  indent = { enabled = true },
  picker = {
    hidden = true,
    layout = { preset = 'ivy_split' },
    matcher = { frecency = true, history_bonus = true },
    win = {
      input = {
        keys = { ['<c-n>'] = { 'toggle_live', mode = { 'i', 'n' } } },
      },
    },
  },
  explorer = { enabled = false },
  terminal = { enabled = true, auto_close = true, win = { position = 'left' } },
  lazygit = { enabled = true, win = { position = 'float' } },
  zen = {
    enabled = true,
    toggles = {
      dim = true, indent = false, git_signs = false, diagnostics = false,
      line_number = false, relative_number = false, signcolumn = 'no',
    },
    show = { statusline = false, tabline = false },
    zoom = {
      show = { statusline = false, tabline = false },
      win = { backdrop = true, width = 0 },
    },
  },
  win = { enabled = true },
  notifier = { enabled = true },
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    _G.dd = function(...) snacks.debug.inspect(...) end
    _G.bt = function() snacks.debug.backtrace() end
    vim.print = _G.dd
  end,
})

-- Picker keymaps
vim.keymap.set('n', '<leader>hu', function() snacks.picker.undo() end, { desc = '[H]istory [U]ndo' })
vim.keymap.set('n', '<leader><leader>', function() snacks.picker.buffers() end, { desc = 'Open buffers' })
vim.keymap.set('n', '<leader>sc', function() snacks.picker.resume() end, { desc = '[S]earch [C]ontinue' })
vim.keymap.set('n', '<leader>sf', function() snacks.picker.smart { filter = { cwd = true } } end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', function() snacks.picker.grep() end, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>gel', function() snacks.picker.git_log() end, { desc = '[G]it [E]xplore [L]og' })
vim.keymap.set('n', '<leader>geb', function() snacks.picker.git_branches() end, { desc = '[G]it [E]xplore [B]ranches' })
vim.keymap.set('n', '<leader>ged', function() snacks.picker.git_diff() end, { desc = '[G]it [E]xplore [D]iff' })
vim.keymap.set('n', '<leader>Nc', function() snacks.picker.commands() end, { desc = '[N]eovim [C]ommands' })
vim.keymap.set('n', '<leader>NC', function() snacks.picker.colorschemes() end, { desc = '[N]eovim [C]olorschemes' })
vim.keymap.set('n', '<leader>Nh', function() snacks.picker.help() end, { desc = '[N]eovim [H]elp' })
vim.keymap.set('n', '<leader>Nk', function() snacks.picker.keymaps() end, { desc = '[N]eovim [K]eymaps' })
vim.keymap.set('n', '<leader>/', function() snacks.picker.grep { sources = { buffers = { current = true } } } end, { desc = 'Search in current buffer' })
vim.keymap.set('n', '<leader>s/', function() snacks.picker.grep { buffers = true } end, { desc = '[S]earch in open buffers' })
vim.keymap.set('n', '<leader>sld', function() snacks.picker.diagnostics() end, { desc = '[S]earch [L]SP [D]iagnostics' })
vim.keymap.set('n', '<leader>slr', function() snacks.picker.lsp_references() end, { desc = '[S]earch [L]SP [R]eferences' })
vim.keymap.set('n', '<leader>sli', function() snacks.picker.lsp_implementations() end, { desc = '[S]earch [L]SP [I]mplementations' })
vim.keymap.set('n', '<leader>sld', function() snacks.picker.lsp_definitions() end, { desc = '[S]earch [L]SP [D]efinitions' })
vim.keymap.set('n', '<leader>sls', function() snacks.picker.lsp_symbols() end, { desc = '[S]earch [L]SP [S]ymbols' })
vim.keymap.set('n', '<leader>slS', function() snacks.picker.lsp_workspace_symbols() end, { desc = '[S]earch [L]SP Workspace [S]ymbols' })
vim.keymap.set('n', '<leader>slt', function() snacks.picker.lsp_type_definitions() end, { desc = '[S]earch [L]SP [T]ype Definitions' })
vim.keymap.set('n', '<leader>lq', function()
  vim.diagnostic.setqflist { open = false }
  snacks.picker.qflist()
end, { desc = '[L]SP [Q]uickfixes' })

-- Terminal keymaps
vim.keymap.set({ 'n', 't' }, '<c-,>', function()
  snacks.terminal.open(nil, { count = #snacks.terminal.list() + 1 })
end, { desc = 'Create new terminal' })
vim.keymap.set('n', '<leader>jf', function()
  snacks.terminal.open(nil, { count = #snacks.terminal.list() + 1, win = { position = 'float' }, auto_close = true })
end, { desc = '[F]loating terminal' })
vim.keymap.set('n', '<leader>jt', function() snacks.terminal.toggle() end, { desc = '[T]oggle terminal' })
vim.keymap.set({ 'n', 't' }, '<c-;>', function()
  local terms = snacks.terminal.list()
  if #terms == 0 then snacks.terminal.open(); return end
  local has_visible = false
  for _, term in pairs(terms) do
    if term:win_valid() then has_visible = true; break end
  end
  for _, term in pairs(terms) do
    if has_visible then term:hide() else term:show() end
  end
end, { desc = 'Toggle all terminals' })

-- Terminal selector
vim.keymap.set('n', '<leader>js', function()
  local sterms = snacks.terminal.list()
  if #sterms == 0 then vim.notify('No open terminals', vim.log.levels.WARN); return end
  local terms = {}
  for k, _ in pairs(sterms) do terms[k] = k end
  snacks.picker.select(terms, {
    prompt = 'Select terminal',
    format_item = function(item) return string.format('Terminal %d', item) end,
  }, function(item)
    if item == nil then return end
    sterms[item]:toggle()
  end)
end, { desc = '[S]elect open terminals' })

-- LazyGit
vim.keymap.set('n', '<leader>gl', function() snacks.lazygit.open() end, { desc = '[L]azyGit' })

-- Zen
vim.keymap.set('n', '<c-b>', function() snacks.zen() end, { desc = '[Z]en' })
vim.keymap.set('n', '<c-s-b>', function() snacks.zen.zoom() end)

-- Scratch
vim.keymap.set('n', '<leader>Nso', function() snacks.scratch() end, { desc = '[S]cratch [O]pen' })
vim.keymap.set('n', '<leader>Nss', function() snacks.scratch.select() end, { desc = '[S]cratch [S]elect' })

-- vim: ts=2 sts=2 sw=2 et
