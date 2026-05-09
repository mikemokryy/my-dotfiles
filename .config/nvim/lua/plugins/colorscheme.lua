return {
  -- colorscheme
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    name = "nightfox",
    opts = {
      options = {
        transparent = true,
        styles = {
          comments = "italic",
        },
        inverse = {
          -- Inverse highlight for different types
          visual = true,
          search = true,
        },
      },
    },
  },

  {
    "catppuccin/nvim",
    enabled = false,
  },
}
