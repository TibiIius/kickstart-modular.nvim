local function gh(repo) return 'https://github.com/' .. repo end

-- Useful plugin to show you pending keybinds.
vim.pack.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>h', group = '[H]istory' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>sl', group = '[S]earch [L]SP' },
    { '<leader>S', group = '[S]cooter' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>g', group = 'Git', mode = { 'n', 'v' } },
    { '<leader>ge', group = '[G]it [E]xplore' },
    { '<leader>gD', group = '[G]it [D]iffview' },
    { '<leader>e', group = '[E]xplorer' },
    { '<leader>j', group = 'Terminal' },
    { '<leader>l', group = '[L]SP' },
    { '<leader>d', group = '[D]AP' },
    { '<leader>ds', group = '[D]AP [S]tep' },
    { '<leader>N', group = '[N]eovim' },
    { '<leader>Ns', group = '[N]eovim [S]cratch' },
  },
}

-- vim: ts=2 sts=2 sw=2 et
