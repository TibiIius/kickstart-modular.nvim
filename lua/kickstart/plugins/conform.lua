vim.g.format_on_save_enable = true

return {
  {
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
      {
        '<leader>tf',
        function()
          vim.g.format_on_save_enable = not vim.g.format_on_save_enable
          if vim.g.format_on_save_enable then
            vim.notify('Format on save: Enabled', vim.log.levels.INFO, { title = 'Conform' })
          else
            vim.notify('Format on save: Disabled', vim.log.levels.INFO, { title = 'Conform' })
          end
        end,
        desc = '[T]oggle [F]ormat on Save',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(_)
        if not vim.g.format_on_save_enable then
          return nil
        end
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        cpp = { 'clang_format' },
        c = { 'clang_format' },
        h = { 'clang_format' },
        -- We run via ruff lsp
        python = {
          -- To fix auto-fixable lint errors.
          'ruff_fix',
          -- To run the Ruff formatter.
          'ruff_format',
          -- To organize the imports.
          'ruff_organize_imports',
          stop_after_first = false,
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
