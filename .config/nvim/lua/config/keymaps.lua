-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = false, silent = true }

-- Delete a word without saving last symbol
keymap.set("n", "x", '"_x')

-- Paste without buffer change
keymap.set("x", "<leader>p", '"_dP', opts)

keymap.set("n", ";w", ":update<Return>", opts)
keymap.set("n", ";q", ":quit<Return>", opts)

-- Move window
keymap.set("n", "<Leader>h", "<C-w>h", { desc = "Go to Left Window" })
keymap.set("n", "<Leader>k", "<C-w>k", { desc = "Go to Upper Window" })
keymap.set("n", "<Leader>j", "<C-w>j", { desc = "Go to Lower Window" })
keymap.set("n", "<Leader>l", "<C-w>l", { desc = "Go to Right Window" })

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><", { desc = "Resize Window Left" })
keymap.set("n", "<C-w><right>", "<C-w>>", { desc = "Resize Window Right" })
keymap.set("n", "<C-w><up>", "<C-w>+", { desc = "Resize Window Up" })
keymap.set("n", "<C-w><down>", "<C-w>-", { desc = "Resize Window Down" })

-- Increment/decrement
keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })

-- Diagnostics
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end

keymap.set("n", "<C-j>", diagnostic_goto(true), { noremap = false, desc = "Next Diagnostic" })

-- Restart LSP
keymap.set("n", "<leader>R", ":LspRestart<Return>", { noremap = false, desc = "Restart LSP" })

-- Codediff
keymap.set("n", "<leader>cv", ":CodeDiff<Return>", { desc = "Codediff viewer" })

-- Disable arrows
keymap.set("", "<up>", "", opts)
keymap.set("", "<down>", "", opts)
keymap.set("", "<left>", "", opts)
keymap.set("", "<right>", "", opts)
