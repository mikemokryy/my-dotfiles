-- Temporary workarounds for upstream Neovim bugs.
--
-- POLICY: review this file on every Neovim upgrade. Remove each workaround as
-- soon as the installed Neovim includes the upstream fix (check the linked
-- issue/PR), and delete this file once it is empty. Never carry a workaround
-- forward into a new Neovim major version without re-checking the issue.
--
-- Workaround for neovim/neovim#40290, fixed by neovim/neovim#42301 (merged
-- 2026-10-21, after the 0.12.5 release): the treesitter fold module refreshes
-- every tracked buffer when 'foldminlines' is set, without checking the buffer
-- is still valid. codediff's compact mode sets it on each file switch, which
-- crashes with "Invalid buffer id" once a diff buffer has been wiped. Drop that
-- refresh autocmd; it only matters when changing foldminlines/foldnestmax.
--
-- TODO: delete this file once your Neovim includes #42301. Verify by checking
-- that the `_fold.lua` OptionSet callback calls nvim_buf_is_valid() before
-- FoldInfo.new().
pcall(require, "vim.treesitter._fold")
for _, au in ipairs(vim.api.nvim_get_autocmds({ event = "OptionSet" })) do
  if au.desc == "Refresh treesitter folds" then
    vim.api.nvim_del_autocmd(au.id)
  end
end
