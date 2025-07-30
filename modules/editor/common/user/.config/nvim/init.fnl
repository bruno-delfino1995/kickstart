(import-macros {: g! : map!} :hibiscus.vim)

(local lazy (require "lazy"))

(map! ["" :noremap :silent] "<space>" "<nop>")
(g! mapleader " ")
(g! maplocalleader " ")	

(lazy.setup {
    :defaults {:lazy false} :git {:timeout 120}
    :spec [[:udayvir-singh/tangerine.nvim]
           [:udayvir-singh/hibiscus.nvim]
           {:import "plugins"}]})

(require "user.neovide")
(require "user.options")
(require "user.keymaps")
(require "user.lsp")

{}
