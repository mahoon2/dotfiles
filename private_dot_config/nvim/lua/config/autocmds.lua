-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function set_window_border_hl()
  vim.api.nvim_set_hl(0, "WinSeparator", {
    fg = "#7bb9fa",
    bold = true,
  })
end

local border_hl_group = vim.api.nvim_create_augroup("mahoon_window_border_hl", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = border_hl_group,
  callback = function()
    vim.schedule(set_window_border_hl)
  end,
})

vim.schedule(set_window_border_hl)
