local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  { src = gh 'amitds1997/remote-nvim.nvim' },
  { src = gh 'MunifTanjim/nui.nvim' },
}

require('remote-nvim').setup {
  client_callback = function(port, workspace_config)
    local cmd = ('wezterm cli set-tab-title --pane-id $(wezterm cli spawn nvim --server localhost:%s --remote-ui) %s'):format(
      port,
      ("'Remote: %s'"):format(workspace_config.host)
    )
    vim.fn.jobstart(cmd, {
      detach = true,
      on_exit = function(job_id, exit_code, event_type)
        print('Client', job_id, 'exited with code', exit_code, 'Event type:', event_type)
      end,
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
