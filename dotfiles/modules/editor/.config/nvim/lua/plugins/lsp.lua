return {
  -- simple to use package installer
  {
    'williamboman/mason.nvim',
    config = true,
  },

  -- bridge the gap between lsp client and lsp server installation
  {
    'williamboman/mason-lspconfig.nvim',
  },

  -- enable LSP
  'neovim/nvim-lspconfig',

  -- list your tokens in a side buffer
  {
    'stevearc/aerial.nvim',
    config = true,
  },

  -- stop opening files in your info splits
  {
    'stevearc/stickybuf.nvim',
    config = true,
  },
}
