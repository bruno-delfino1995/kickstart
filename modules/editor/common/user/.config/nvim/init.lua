local function bootstrap(plugin, branch)
  local user, repo = string.match(plugin, "(.+)/(.+)")
  local repo_path = vim.fn.stdpath("data") .. "/lazy/" .. repo

  vim.opt.rtp:prepend(repo_path)

  if not (vim.uv or vim.loop).fs_stat(repo_path) then
    vim.notify("Installing " .. plugin .. " " .. branch)

    local repo_url = "https://github.com/" .. plugin .. ".git"
    local out = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=" .. branch,
      repo_url,
      repo_path
    })

    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone " .. plugin .. ":\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end

  return repo_path
end

bootstrap("udayvir-singh/tangerine.nvim", "v2.9")
bootstrap("udayvir-singh/hibiscus.nvim", "v1.7")
bootstrap("folke/lazy.nvim", "v11.17.1")

require("tangerine").setup({
  compiler = {
    verbose = false,
    hooks = {"onsave", "oninit"}
  }
})