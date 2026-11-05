-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.wrap = true -- Wrap lines
vim.opt.mouse = ""
vim.opt.shell = "fish"

-- Lazyvim global variables
vim.g.lazyvim_python_lsp = "pylsp"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_eslint_auto_format = false
vim.g.lazyvim_picker = "fzf"

vim.g.lazyvim_cmp = "blink.cmp"

vim.g.lazyvim_ts_lsp = "vtsls"

vim.g.snacks_animate = false
vim.g.ai_cmp = false

-- Quality of life options
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.winborder = "rounded" -- rounded borders on all floating windows
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.iskeyword:append("-") -- kebab-case / CSS class word motions
vim.opt.fillchars:append("diff:╱")

-- Use neo-tree as the file explorer (LazyVim v15 default mechanism)
vim.g.lazyvim_explorer = "neo-tree"
