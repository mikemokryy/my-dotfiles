-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Fix OpenCode prompt key handling (see file header).
require("config.opencode")

-- upstream workarounds (review on every Neovim upgrade; delete once fixed upstream — see file header)
require("config.workarounds")
