local function gh(repo) return 'https://github.com/' .. repo end

-- [[ Snippet Engine ]]
vim.pack.add { { src = gh 'L3MON4D3/LuaSnip' } }
require('luasnip').setup {}

-- [[ Autocomplete Engine ]]
vim.pack.add { { src = gh 'saghen/blink.cmp' } }
require('blink.cmp').setup {
  keymap = {
    preset = 'default',
  },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 0 },
    menu = {
      auto_show = true,
      draw = {
        columns = { { 'kind_icon' }, { 'label', gap = 1 } },
        components = {
          label = {
            text = function(ctx)
              return require('colorful-menu').blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require('colorful-menu').blink_components_highlight(ctx)
            end,
          },
        },
      },
    },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    per_filetype = {
      sql = { 'snippets', 'dadbod', 'buffer' },
    },
    providers = {
      dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
      path = {
        opts = {
          get_cwd = function(_)
            return vim.fn.getcwd()
          end,
        },
      },
    },
  },

  snippets = { preset = 'luasnip' },

  fuzzy = { implementation = 'prefer_rust_with_warning' },

  signature = { enabled = true },
}

-- vim: ts=2 sts=2 sw=2 et
