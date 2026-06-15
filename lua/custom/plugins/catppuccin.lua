local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'catppuccin/nvim', name = 'catppuccin' } }

require('catppuccin').setup {
  flavour = 'auto',
  background = { light = 'latte', dark = 'macchiato' },
  transparent_background = true,
  float = { transparent = true, solid = false },
  show_end_of_buffer = false,
  term_colors = true,
  dim_inactive = { enabled = true, shade = 'dark', percentage = 0.15 },
  no_italic = false,
  no_bold = false,
  no_underline = false,
  styles = { comments = { 'italic' } },
  color_overrides = {},
  custom_highlights = {},
  auto_integrations = true,
  default_integrations = true,
  integrations = {
    blink_cmp = { style = 'bordered' },
    dropbar = { enabled = true, color_mode = true },
    snacks = { enabled = true, indent_scope_color = 'pink' },
    mini = { enabled = true },
    markdown = true,
    dap = true,
    dap_ui = true,
    dadbod_ui = true,
    copilot_vim = true,
    lsp_trouble = true,
    mason = true,
    neotree = true,
    native_lsp = { enabled = true },
    which_key = true,
  },
}

vim.cmd.colorscheme 'catppuccin'

-- vim: ts=2 sts=2 sw=2 et
