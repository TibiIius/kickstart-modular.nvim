vim.pack.add({
  spec = {
    { 'folke/tokyonight.nvim' },
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      styles = {
        comments = { italic = false },
      },
    }

    vim.cmd.colorscheme 'tokyonight-night'
  end,
})
