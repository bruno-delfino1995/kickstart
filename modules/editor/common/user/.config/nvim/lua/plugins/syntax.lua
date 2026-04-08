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
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local install_dir = vim.fn.stdpath('data') .. '/site'
      vim.opt.runtimepath:append(install_dir)

      local ts = require('nvim-treesitter')
      ts.setup({ install_dir = install_dir })

      -- Parsers to install at startup (empty for all; no-op if already present)
      local ensure_installed = { }
      ts.install(ensure_installed)

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter-setup', { clear = true }),
        callback = function(ev)
          local buf = ev.buf
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang then
            return
          end

          if not pcall(vim.treesitter.language.add, lang) then
            -- Parser not installed: trigger a non-blocking background install.
            -- Highlighting will work on the next buffer open for this filetype.
            ts.install({ lang })
            return
          end

          -- pcall guards against filetypes where language.add succeeds but no
          -- usable parser exists (e.g. fzf-lua's "fzf" filetype).
          if not pcall(vim.treesitter.start, buf, lang) then
            return
          end

          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldlevel = 99
        end,
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
