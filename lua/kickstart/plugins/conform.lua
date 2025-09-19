return {
  { -- Autoformat
    'stevearc/conform.nvim',
    dependencies = {
      'mason-org/mason.nvim',
    },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = false, cpp = false }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        cpp = { 'clang_format' },
        c = { 'clang_format' },
        h = { 'clang_format' },
        -- We run via ruff lsp
        python = {
          -- To fix auto-fixable lint errors.
          "ruff_fix",
          -- To run the Ruff formatter.
          "ruff_format",
          -- To organize the imports.
          "ruff_organize_imports",
          stop_after_first = false
        },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'biome', 'biome-organize-imports', 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'biome', 'biome-organize-imports', 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'biome', 'biome-organize-imports', 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'biome', 'biome-organize-imports', 'prettierd', 'prettier', stop_after_first = true },
        vue = { 'biome', 'biome-organize-imports', 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', 'biome', 'biome-organize-imports', stop_after_first = true },
        jsonc = { 'prettierd', 'prettier', 'biome', 'biome-organize-imports', stop_after_first = true },
        jinja = { 'djlint', stop_after_first = true },
      },
      formatters = {
        clang_format = {
          command = '/usr/local/bin/clang-format',
          args = { '-style=file:.clang-format', '-assume-filename', '$FILENAME' },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
