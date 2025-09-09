return {
  'TibiIius/snacks.nvim',
  branch = 'fix/add-new-terminals-to-table',
  priority = 1000,
  lazy = false,
  dependencies = { 'folke/noice.nvim' },
  keys = {
    -- Zen
    {
      '<leader>z',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle Zen Mode',
    },
    {
      '<leader>Z',
      function()
        Snacks.zen.zoom()
      end,
      desc = 'Toggle Zen Mode',
    },

    -- Terminal
    {
      '<leader>js',
      function()
        local snacks = require 'snacks'
        local sterms = snacks.terminal.list()
        local terms = {}

        for k, v in pairs(sterms) do
          terms[k] = k
        end

        if #terms == 0 then
          vim.notify('No open terminals', vim.log.levels.WARN)
          return
        end

        Snacks.picker.select(terms, {
          prompt = 'Select terminal:',
          format_item = function(item)
            return string.format('Terminal (id: %d)', item)
          end,
        }, function(item)
          sterms[item]:toggle()
        end)
      end,
      desc = '[S]elect open terminals',
    },
    {
      '<leader>jn',
      function()
        Snacks.terminal.open()
      end,
      desc = '[N]ew terminal',
    },
    {
      '<leader>jf',
      function()
        Snacks.terminal.open(nil, { win = { position = 'float' } })
      end,
      desc = '[F]loating terminal',
    },
    {
      '<leader>jt',
      function()
        Snacks.terminal.toggle()
      end,
      desc = '[T]oggle terminal',
    },
    -- LazyGit
    {
      '<leader>gl',
      function()
        Snacks.lazygit.open()
      end,
      desc = '[L]azyGit',
    },

    -- Explorer
    {
      '<leader>eo',
      function()
        Snacks.explorer.open()
      end,
      desc = '[E]xplorer [O]pen',
    },
    {
      '<leader>er',
      function()
        Snacks.explorer.reveal()
      end,
      desc = '[E]xplorer [R]eveal',
    },

    -- Zen
    {
      '<leader>z',
      function()
        Snacks.zen()
      end,
      desc = '[Z]en',
    },

    {
      '<leader>Z',
      function()
        Snacks.zen.zoom()
      end,
      desc = '[Z]en [Z]oom',
    },
  },
  ---@type snacks.Config
  opts = {
    ---@type table<string, snacks.win.Config>
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
        wo = {
          winhighlight = 'NormalFloat:Normal',
        },
        w = {
          snacks_main = true,
        },
      },
    },
    ---@type snacks.indent.Config
    indent = {
      enabled = true,
    },
    ---@type snacks.picker.Config
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          layout = {
            layout = { position = 'right' },
          },
        },
      },
    },
    ---@type snacks.explorer.Config
    explorer = {
      enabled = true,
    },
    ---@type snacks.terminal.Config
    terminal = {
      enabled = true,
      auto_close = true,
      win = {
        width = 0.25,
        position = 'left',
      },
    },
    ---@type snacks.lazygit.Config
    lazygit = {
      enabled = true,
      win = {
        position = 'float',
      },
    },
    ---@type snacks.zen.Config
    zen = {
      enabled = true,
      toggles = {
        dim = true,
        indent = false,
        git_signs = false,
        diagnostics = false,
        line_number = false,
        relative_number = false,
        signcolumn = 'no',
      },
      show = { statusline = false, tabline = false },
      zoom = {
        show = { statusline = false, tabline = false },
        win = {
          backdrop = true,
          width = 0, -- full width
        },
      },
    },
    ---@type snacks.win.Config
    win = {
      enabled = true,
    },
    ---@type snacks.notifier.Config
    notifier = {
      enabled = true,
    },
  },
  config = function(_, opts)
    local notify = vim.notify
    require('snacks').setup(opts)
    -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
    -- this is needed to have early notifications show up in noice history
    vim.notify = notify

    -- Notifier
    -- From snacks examples
    ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd('LspProgress', {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= 'table' then
          return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ('[%3d%%] %s%s'):format(
                value.kind == 'end' and 100 or value.percentage or 100,
                value.title or '',
                value.message and (' **%s**'):format(value.message) or ''
              ),
              done = value.kind == 'end',
            }
            break
          end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        vim.notify(table.concat(msg, '\n'), 'info', {
          id = 'lsp_progress',
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}
