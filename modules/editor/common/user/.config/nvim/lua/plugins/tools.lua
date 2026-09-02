return {
  -- tabpage for diffs
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    config = true,
    keys = { { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView' } },
  },

  -- a better markdown language without flavors
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    config = function()
      require('orgmode').setup({
        org_agenda_files = '~/Sync/Brain/**/*',
        org_default_notes_file = '~/Sync/Brain/Inbox.org',
      })

      vim.lsp.enable('org')
    end,
  }
}
