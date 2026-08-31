local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'catppuccin/nvim', name = 'catppuccin' } }

local wants_transparent = not vim.g.neovide

require('catppuccin').setup {
  flavour = 'auto',
  background = { light = 'latte', dark = 'macchiato' },
  transparent_background = wants_transparent,
  float = { transparent = wants_transparent },
  show_end_of_buffer = false,
  term_colors = true,
  dim_inactive = { enabled = false, shade = 'dark', percentage = 0.15 },
  no_italic = false,
  no_bold = false,
  no_underline = false,
  styles = { comments = { 'italic' } },
  color_overrides = {},
  auto_integrations = true,
  default_integrations = true,
  integrations = {
    blink_cmp = { enabled = true, style = 'bordered' },
    dropbar = { enabled = true, color_mode = true },
    snacks = { enabled = true },
    mini = true,
    markdown = true,
    dap = true,
    dap_ui = true,
    dadbod_ui = true,
    copilot_vim = true,
    lsp_trouble = true,
    mason = true,
    neotree = true,
    native_lsp = true,
    which_key = true,
  },
}

vim.cmd.colorscheme 'catppuccin-nvim'

-- vim: ts=2 sts=2 sw=2 et
