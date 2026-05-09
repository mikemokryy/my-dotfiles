return {
  -- LSP tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "vue-language-server",
        "lua-language-server",
        "html-lsp",
        "ruff",
        "python-lsp-server",
        "yaml-language-server",
        "vtsls",
        "tailwindcss-language-server",
        "css-lsp",
        "astro-language-server",
        "svelte-language-server",
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        pylsp = {
          settings = {
            -- python = {
            --   pythonPath = vim.fn.exepath("python3"),
            -- },
            ruff = {
              enabled = true,
              lineLength = 88,
            },
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            mccabe = { enabled = false },
          },
        },
      },
    },
  },
}
