return {
  -- editorconfig for vim
  'editorconfig/editorconfig-vim',

  -- formatting as if it were a language server
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local null_ls = require('null-ls')

      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics

      null_ls.setup({
        sources = {
          formatting.stylua,
          -- diagnostics.credo
        },
      })
    end,
  },
}
