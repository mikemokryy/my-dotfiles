-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Register OpenCode prompt filetype after LazyVim but before command-line files load.
require("config.opencode")

-- upstream workarounds (review on every Neovim upgrade; delete once fixed upstream — see file header)
require("config.workarounds")
