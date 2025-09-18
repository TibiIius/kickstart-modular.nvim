-- Highlight todo, notes, etc in comments
return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'folke/snacks.nvim',
    },
    opts = { signs = false },
    keys = {
      {
        '<leader>st',
        function()
          Snacks.picker.todo_comments()
        end,
        desc = '[S]earch All [T]ODO',
      },
      {
        '<leader>sT',
        function()
          Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME', 'HACK', 'PERF', 'WARN', 'WARNING' } }
        end,
        desc = '[S]earch [T]ODO (only TODO, FIX, FIXME, HACK, PERF, WARN, WARNING)',
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
