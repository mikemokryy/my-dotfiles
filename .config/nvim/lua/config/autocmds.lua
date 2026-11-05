-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable relative line numbers in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  command = "set norelativenumber",
})

-- Enable relative line numbers and leave paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set relativenumber | set nopaste",
})

-- Cursorline only in the active window
local cursorline_group = vim.api.nvim_create_augroup("UserCursorline", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = cursorline_group,
  command = "setlocal cursorline",
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = cursorline_group,
  command = "setlocal nocursorline",
})

-- Trigger filetype for Podfile
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "Podfile",
  command = "setf ruby",
})
