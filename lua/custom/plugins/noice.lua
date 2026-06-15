local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  { src = gh 'folke/noice.nvim' },
  { src = gh 'MunifTanjim/nui.nvim' },
}

require('noice').setup {
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = false,
    inc_rename = true,
    lsp_doc_border = true,
  },
}

-- vim: ts=2 sts=2 sw=2 et
