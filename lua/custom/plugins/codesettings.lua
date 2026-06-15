local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'mrjones2014/codesettings.nvim' } }

require('codesettings').setup {
  config_file_paths = { '.vscode/settings.json', 'codesettings.json', 'lspsettings.json', 'codesettings.local.json', '.codesettings.json', '.lspsettings.json', '.codesettings.local.json' },
  jsonc_filetype = true,
  jsonls_integration = true,
  live_reload = false,
  loader_extensions = { 'codesettings.extensions.vscode' },
  lua_ls_integration = true,
  merge_lists = 'append',
  root_dir = nil,
}

-- vim: ts=2 sts=2 sw=2 et
