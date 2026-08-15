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
      map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
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

-- TypeScript 7+ (native Go port) ships its own LSP (`tsc --lsp`) and no longer
-- provides the JS tsserver that typescript-language-server (ts_ls) needs.
-- Detect which one the project root uses and only attach the matching server.
local function has_native_ts(root) return vim.uv.fs_stat(vim.fs.joinpath(root, 'node_modules', 'typescript', 'lib', 'getExePath.js')) ~= nil end

-- Reuse nvim-lspconfig's default root detection (incl. deno exclusion)
local function default_root_dir(name) return dofile(vim.api.nvim_get_runtime_file('lsp/' .. name .. '.lua', false)[1]).root_dir end

-- LSP servers
local servers = {
  clangd = {
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
  },
  gopls = {},
  basedpyright = { disableOrganizeImports = true },
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
  -- TypeScript <=5 projects (JS-based tsserver)
  ts_ls = {
    root_dir = function(bufnr, on_dir)
      default_root_dir 'ts_ls'(bufnr, function(root)
        if not has_native_ts(root) then on_dir(root) end
      end)
    end,
  },
  -- TypeScript 7+ projects (built-in native LSP; binary was renamed tsgo -> tsc)
  tsgo = {
    cmd = function(dispatchers, config)
      local cmd = 'tsgo'
      local root = (config or {}).root_dir
      if root then
        for _, bin in ipairs { 'tsc', 'tsgo' } do
          local local_cmd = vim.fs.joinpath(root, 'node_modules', '.bin', bin)
          if vim.fn.executable(local_cmd) == 1 then
            cmd = local_cmd
            break
          end
        end
      end
      return vim.lsp.rpc.start({ cmd, '--lsp', '--stdio' }, dispatchers)
    end,
    root_dir = function(bufnr, on_dir)
      default_root_dir 'tsgo'(bufnr, function(root)
        if has_native_ts(root) then on_dir(root) end
      end)
    end,
  },
  biome = {},
  svelte = {},
  tombi = {},
  ansiblels = {},
  jdtls = {},
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

require('mason-tool-installer').setup {}

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

-- vim: ts=2 sts=2 sw=2 et
