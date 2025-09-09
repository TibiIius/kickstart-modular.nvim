return {
  'TibiIius/snacks.nvim',
  branch = 'fix/add-new-terminals-to-table',
  priority = 1000,
  lazy = false,
  dependencies = { 'folke/noice.nvim' },
  opts = {
    indent = {
      enabled = true,
    },
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
    explorer = {
      enabled = true,
    },
    terminal = {
      enabled = true,
      auto_close = true,
    },
    lazygit = {
      enabled = true,
    },
    zen = {
      enabled = true,
    },
    zoom = {
      show = { statusline = false, tabline = false },
      win = {
        backdrop = true,
        width = 0, -- full width
      },
    },
    win = {
      enabled = true,
    },
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

    -- LazyGit
    vim.keymap.set('n', '<leader>gl', function()
      Snacks.lazygit.open()
    end, { desc = '[L]azyGit' })

    -- Terminal
    local newtermopts = {
      auto_close = true,
      win = {
        width = 0.25,
        position = 'left',
      },
    }
    vim.keymap.set('n', '<leader>jn', function()
      Snacks.terminal.open(nil, newtermopts)
    end, { desc = '[N]ew terminal' })

    vim.keymap.set('n', '<leader>jf', function()
      Snacks.terminal.open 'zsh'
    end, { desc = '[F]loating terminal' })

    vim.keymap.set('n', '<leader>jt', function()
      Snacks.terminal.toggle(nil, newtermopts)
    end, { desc = '[T]oggle terminal' })

    vim.keymap.set('n', '<leader>js', function()
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
    end, { desc = '[S]elect open terminals' })

    -- Explorer
    vim.keymap.set('n', '<leader>bo', function()
      Snacks.explorer.open()
    end, { desc = '[O]pen File [B]rowser' })

    vim.keymap.set('n', '<leader>br', function()
      Snacks.explorer.reveal()
    end, { desc = '[R]eveal in File [B]rowser' })

    -- Zen
    vim.keymap.set('n', '<leader>z', function()
      Snacks.zen()
    end, { desc = '[Z]en' })

    vim.keymap.set('n', '<leader>Z', function()
      Snacks.zen.zoom()
    end, { desc = '[Z]en [Z]oom' })
  end,
}
