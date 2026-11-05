return {
  -- Mason tools (LSP servers are installed automatically by mason-lspconfig;
  -- formatters and linters live here too, so there is a single source of truth)
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "selene",
        "luacheck",
        "shellcheck",
        "prettierd",
        "oxfmt",
      },
    },
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        virtual_text = {
          format = function(diagnostic)
            return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
          end,
        },
      },
      servers = {
        -- HTML / CSS
        cssls = {
          settings = {
            css = { lint = { emptyRules = "ignore" } },
            scss = { lint = { emptyRules = "ignore" } },
            less = { lint = { emptyRules = "ignore" } },
          },
        },
        html = {},

        -- oxfmt is installed as a conform formatter, not as an LSP server
        oxfmt = { enabled = false },

        -- Lua (config editing)
        lua_ls = {
          settings = {
            Lua = {
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                unusedLocalExclude = { "_*" },
              },
            },
          },
        },

        -- Python
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
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

        -- Swift
        sourcekit = {
          cmd = {
            "/usr/bin/sourcekit-lsp",
          },
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          },
        },

        -- TypeScript / JavaScript
        vtsls = {
          on_attach = function(client)
            if client and client.server_capabilities.semanticTokensProvider then
              client.server_capabilities.semanticTokensProvider.range = false
            end
          end,
          settings = {
            typescript = {
              preferences = {
                useAliasesForRenames = false,
              },
            },
          },
        },
      },
    },
  },
}
