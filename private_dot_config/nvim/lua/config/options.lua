-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.clipboard = "unnamedplus"
vim.api.nvim_set_hl(0, "WinSeparator", {
  fg = "#7bb9fa",
  bold = true,
})

local function prepend_path(path)
  if vim.fn.isdirectory(path) == 0 then
    return
  end

  local current_path = vim.env.PATH or ""
  for entry in string.gmatch(current_path, "([^:]+)") do
    if entry == path then
      return
    end
  end

  vim.env.PATH = path .. ":" .. current_path
end

prepend_path(vim.fn.expand("~/.local/go/bin"))
prepend_path(vim.fn.expand("~/go/bin"))
