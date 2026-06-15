-- Add indentation guides even on blank lines

vim.pack.add({
  spec = {
    { 'lukas-reineke/indent-blankline.nvim' },
  },
  config = function()
    require('ibl').setup {}
  end,
})
