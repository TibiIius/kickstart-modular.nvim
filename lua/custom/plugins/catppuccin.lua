return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  config = function()
    require('catppuccin').setup {
      flavour = 'auto', -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = 'latte',
        dark = 'macchiato',
      },
      transparent_background = false, -- disables setting the background color.
      float = {
        transparent = false, -- enable transparent floating windows
        solid = false, -- use solid styling for floating windows, see |winborder|
      },
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { 'italic' }, -- Change the style of comments
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      custom_highlights = {},
      auto_integrations = true,
      default_integrations = true,
      integrations = {
        blink_cmp = {
          style = 'bordered',
        },
        dropbar = {
          enabled = true,
          color_mode = true,
        },
        snacks = {
          enabled = true,
          indent_scope_color = 'pink',
        },
        mini = {
          enabled = true,
        },
        markdown = true,
        dap = true,
        dap_ui = true,
        dadbod_ui = true,
        copilot_vim = true,
        gitsigns = true,
        lsp_trouble = true,
        mason = true,
        neotree = true,
        native_lsp = {
          enabled = true,
        },
        which_key = true,
      },
    }

    -- setup must be called before loading
    vim.cmd.colorscheme 'catppuccin'
  end,
}
