local status_ok, mason_lsp = pcall(require, 'mason-lspconfig')
if not status_ok then
  return
end

mason_lsp.setup()

local base_opts = {
  on_attach = require('user.lsp.handlers').on_attach,
  capabilities = require('user.lsp.handlers').capabilities,
}

mason_lsp.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup(base_opts)
  end,
  ['lua_ls'] = function()
    local additional_opts = require('user.lsp.servers.lua_ls')
    local opts = vim.tbl_deep_extend('force', additional_opts, base_opts)

    require('lspconfig').lua_ls.setup(opts)
  end,
  ['jsonls'] = function()
    local additional_opts = require('user.lsp.servers.jsonls')
    local opts = vim.tbl_deep_extend('force', additional_opts, base_opts)

    require('lspconfig').jsonls.setup(opts)
  end,
  ['yamlls'] = function()
    local additional_opts = require('user.lsp.servers.yamlls')
    local opts = vim.tbl_deep_extend('force', additional_opts, base_opts)

    require('lspconfig').yamlls.setup(opts)
  end,
})
