return {
  -- enable LSP
  'neovim/nvim-lspconfig',

  -- simple to use package installer
  {
    'williamboman/mason.nvim',
    config = true,
  },


  -- connect mason to lspconfig and enable servers
  {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
          { "mason-org/mason.nvim", opts = {} },
          "neovim/nvim-lspconfig",
      },
  },

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
