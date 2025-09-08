return {
  'TibiIius/snacks.nvim',
  branch = 'fix/add-new-terminals-to-table',
  priority = 1000,
  lazy = false,
  config = function()
    Snacks.setup {
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
    }

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
