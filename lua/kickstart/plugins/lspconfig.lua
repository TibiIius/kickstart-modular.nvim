local function gh(repo) return 'https://github.com/' .. repo end

-- [[ LSP Configuration ]]

-- Useful status updates for LSP.
vim.pack.add { gh 'j-hui/fidget.nvim' }
require('fidget').setup {}

--  This function gets run when an LSP attaches to a particular buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>ln', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>la', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    map('<leader>lD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    map('<leader>tdt', function()
      local cur = vim.diagnostic.config().virtual_text
      vim.diagnostic.config { virtual_text = not cur }
    end, '[T]oggle [D]iagnostics [T]ext')

    map('<leader>tdl', function()
      local cur = vim.diagnostic.config().virtual_lines
      vim.diagnostic.config { virtual_lines = not cur }
    end, '[T]oggle [D]iagnostics [L]ines')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      vim.lsp.inlay_hint.enable()
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Diagnostic Config
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_lines = false,
  virtual_text = true,
}

-- LSP servers
local servers = {
  clangd = {
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
  },
  gopls = {},
  pyright = { disableOrganizeImports = true },
  python = {
    analysis = { ignore = { '*' } },
  },
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        files = {
          excludeDirs = { '.flatpak', '.flatpak-builder', '.repo', 'build', '_build', 'workdir' },
        },
      },
    },
  },
  ts_ls = {},
  biome = {},
  taplo = {},
  ansiblels = {},
  jsonls = {},
  yamlls = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
      },
    },
  },
  jinja_lsp = { filetypes = { 'jinja' } },
  dockerls = {},
  docker_compose_language_service = {},
}

vim.pack.add {
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}

require('mason').setup {}

local ensure_installed = vim.tbl_keys(servers or {})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

-- vim: ts=2 sts=2 sw=2 et
