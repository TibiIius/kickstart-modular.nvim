return {
  'TibiIius/snacks.nvim',
  branch = 'main',
  priority = 1000,
  lazy = false,
  dependencies = { 'folke/noice.nvim' },
  keys = {
    -- Picker
    {
      '<leader>hu',
      function()
        Snacks.picker.undo()
      end,
      desc = '[H]istory [U]ndo',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Open buffers',
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.smart {
          filter = {
            cwd = true,
          },
        }
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[S]earch by [G]rep',
    },
    {
      '<leader>gel',
      function()
        Snacks.picker.git_log()
      end,
      desc = '[G]it [E]xplore [L]og',
    },
    {
      '<leader>geb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = '[G]it [E]xplore [B]ranches',
    },
    {
      '<leader>ged',
      function()
        Snacks.picker.git_diff()
      end,
      desc = '[G]it [E]xplore [D]iff',
    },
    {
      '<leader>ged',
      function()
        Snacks.picker.git_diff()
      end,
      desc = '[G]it [E]xplore [B]ranches',
    },
    {
      '<leader>Nc',
      function()
        Snacks.picker.commands()
      end,
      desc = '[N]eovim [C]ommands',
    },
    {
      '<leader>NC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = '[N]eovim [C]colorschemes',
    },
    {
      '<leader>Nh',
      function()
        Snacks.picker.help()
      end,
      desc = '[N]eovim [H]elp',
    },
    {
      '<leader>Nk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[N]eovim [K]eymaps',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep {
          sources = {
            buffers = { current = true },
          },
        }
      end,
      desc = 'Search in current buffer',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.grep {
          buffers = true,
        }
      end,
      desc = '[S]earch in open buffers',
    },
    {
      '<leader>sld',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[S]earch [L]SP [D]iagnostics',
    },
    {
      '<leader>slr',
      function()
        Snacks.picker.lsp_references()
      end,
      desc = '[S]earch [L]SP [R]eferences',
    },
    {
      '<leader>sli',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = '[S]earch [L]SP [I]mplementations',
    },
    {
      '<leader>sld',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = '[S]earch [L]SP [D]efinitions',
    },
    {
      '<leader>sls',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = '[S]earch [L]SP [S]ymbols',
    },
    {
      '<leader>slS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = '[S]earch [L]SP Workspace [S]ymbols',
    },
    {
      '<leader>slt',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = '[S]earch [L]SP [T]ype Definitions',
    },
    {
      '<leader>q',
      function()
        Snacks.picker.qflist()
      end,
      desc = '[Q]uickfixes',
    },

    -- Terminal
    {
      '<leader>js',
      function()
        local snacks = require 'snacks'
        local sterms = snacks.terminal.list()

        if #sterms == 0 then
          vim.notify('No open terminals', vim.log.levels.WARN)
          return
        end

        local terms = {}

        for k, _ in pairs(sterms) do
          terms[k] = k
        end

        Snacks.picker.select(terms, {
          prompt = 'Select terminal',
          format_item = function(item)
            return string.format('Terminal %d', item)
          end,
        }, function(item)
          if item == nil then
            return
          end
          sterms[item]:toggle()
        end)
      end,
      desc = '[S]elect open terminals',
    },
    {
      '<c-,>',
      function()
        Snacks.terminal.open(nil, {
          -- TODO: Change this accordingly if the ID change ever hits main
          id = tostring(#Snacks.terminal.list() + 1),
        })
      end,
      desc = 'Create new terminal',
      mode = { 't', 'n' },
    },
    {
      '<leader>jf',
      function()
        Snacks.terminal.open(nil, {
          id = tostring(#Snacks.terminal.list() + 1),
          win = {
            position = 'float',
          },
          auto_close = true,
        })
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
    {
      '<c-;>',
      function()
        local has_visible = false
        local terms = Snacks.terminal.list()

        if #terms == 0 then
          Snacks.terminal.open()
          return
        end

        for _, term in pairs(terms) do
          if term:win_valid() then
            has_visible = true
            break
          end
        end

        if has_visible then
          for _, term in pairs(terms) do
            term:hide()
          end
        else
          for _, term in pairs(terms) do
            term:show()
          end
        end
      end,
      desc = 'Toggle all terminals',
      mode = { 'n', 't' },
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
      '<c-b>',
      function()
        Snacks.zen()
      end,
      desc = '[Z]en',
    },
    {
      '<c-s-b>',
      function()
        Snacks.zen.zoom()
      end,
    },

    -- Scratch
    {
      '<leader>So',
      function()
        Snacks.scratch()
      end,
      desc = '[S]cratch [O]pen',
    },
    {
      '<leader>Ss',
      function()
        Snacks.scratch.select()
      end,
      desc = '[S]cratch [S]elect',
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
      layout = {
        layout = {
          -- Reverse dropdown
          backdrop = false,
          row = 1,
          width = 0.4,
          min_width = 80,
          height = 0.8,
          border = 'none',
          box = 'vertical',
          {
            box = 'vertical',
            border = 'rounded',
            title = '{title} {live} {flags}',
            title_pos = 'center',
            { win = 'input', height = 1, border = 'bottom' },
            { win = 'list', border = 'none' },
          },
          { win = 'preview', title = '{preview}', height = 0.4, border = 'rounded' },
        },
      },
      matcher = {
        frecency = true, -- frecency bonus
        history_bonus = true, -- give more weight to chronological order
      },
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          layout = {
            layout = { position = 'right' },
          },
        },
      },
      win = {
        input = {
          keys = {
            ['<c-n>'] = { 'toggle_live', mode = { 'i', 'n' } },
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

    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command
      end,
    })

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
