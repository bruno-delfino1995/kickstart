local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
  return
end

local handlers = require('user.lsp.handlers')

handlers.setup()

vim.lsp.config('*', {
  capabilities = handlers.capabilities,
})

vim.lsp.config.rust_analyzer.on_attach = handlers.on_attach
vim.lsp.config.lexical.on_attach = handlers.on_attach
vim.lsp.config.gopls.on_attach = handlers.on_attach
