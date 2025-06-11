vim.g.carbon_lazy_init = true

return {
  -- file explorer from need for speed
  {
    'SidOfc/carbon.nvim',
    config = function()
      local carbon = require('carbon')
      carbon.setup({
        auto_open = false,
      })
    end,
  },
}
