return {
  -- context aware comments
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    name = 'ts_context_commentstring',
    init = function ()
      require('ts_context_commentstring').setup({
        enabled = true,
        enable_autocmd = false,
      })
      vim.g.skip_ts_context_commentstring_module = true
    end
  },

  -- manipulate comments
  {
    'terrortylor/nvim-comment',
    name = 'nvim_comment',
    config = true,
  },

  -- prettier folds from the outer world
  {
    'kevinhwang91/nvim-ufo',
    name = 'ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      'nvim-treesitter/nvim-treesitter',
    },
    init = function()
      local ufo = require('ufo')

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', ufo.openAllFolds)
      vim.keymap.set('n', 'zM', ufo.closeAllFolds)
      vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', ufo.closeFoldsWith)
    end,
    opts = {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    },
  },

  -- language parsing from the future
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = 'ts_context_commentstring',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        ensure_installed = { }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        sync_install = false,     -- install languages synchronously (only applied to `ensure_installed`)
        ignore_install = { },  -- list of parsers to ignore installing
        highlight = {
          enable = true,          -- false will disable the whole extension
          disable = { '' },       -- list of language that will be disabled
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = { '' },
        },
        rainbow = {
          enable = true,
          disable = { '' },     -- list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
        },
      })
    end,
  },

  -- don't leave your delimiters alone, integrates with both cmp and treesitter
  {
    'windwp/nvim-autopairs',
    config = function()
      local npairs = require('nvim-autopairs')

      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { 'string', 'source' },
          javascript = { 'string', 'template_string' },
          java = false,
        },
        disable_filetype = { 'TelescopePrompt' },
      })

      local cmp_status_ok, cmp = pcall(require, 'cmp')
      if not cmp_status_ok then
        return
      end

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
    end,
  },

  -- put end after do in elixir/ruby
  'tpope/vim-endwise',
}
