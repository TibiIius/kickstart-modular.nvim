local function gh(repo) return 'https://github.com/' .. repo end

-- Run `install.sh` after Joakker/lua-json5 is installed or updated.
-- Must be registered BEFORE the corresponding vim.pack.add() call.
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('json5-build', { clear = true }),
  callback = function(ev)
    local d = ev.data
    if d.spec.name ~= 'lua-json5' then return end
    if d.kind ~= 'install' and d.kind ~= 'update' then return end
    vim.notify('[lua-json5] running install.sh in ' .. d.path, vim.log.levels.INFO)
    vim.system({ 'sh', './install.sh' }, { cwd = d.path, text = true }, function(obj)
      local level = obj.code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
      vim.schedule(function()
        vim.notify('[lua-json5] install.sh exited ' .. obj.code .. '\n' .. (obj.stderr or ''), level)
      end)
    end):wait() -- synchronous so `require('json5')` works right after add()
  end,
})

vim.pack.add { { src = gh 'Joakker/lua-json5' } }

-- vim: ts=2 sts=2 sw=2 et
