(import-macros {: color!} :hibiscus.vim)

[{1 :RRethy/nvim-base16 ; theme for the night owl
  :lazy false
  :priority 999
  :config (fn [] (color! "base16-unikitty-light")
            (set vim.opt.cursorcolumn false) ; disable column hightlight
            (set vim.opt.cursorline false) ; disable line hightlight
            )}]