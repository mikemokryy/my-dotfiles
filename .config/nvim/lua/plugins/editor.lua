-- M is Meta key (Control)

return {
  -- Quickly jump to any location in the visible buffer
  {
    "folke/flash.nvim",
    enabled = false,
  },

  -- File explorer by NeoTree
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    keys = {
      {
        ";e",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            reveal = true,
          })
        end,
        desc = "Explorer NeoTree (Current Dir)",
      },
    },
    opts = {
      window = {
        position = "float",
      },
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
            ".vscode",
          },
        },
      },
    },
  },

  -- Fuzzy finder
  {
    "ibhagwan/fzf-lua",
    keys = {
      { ";f", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { ";r", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { ";b", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { ";d", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
    },
  },

  -- snacks (file explorer and more)
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },

  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
  },

  -- Diff viewer
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    opts = {
      explorer = {
        auto_open_on_cursor = true, -- auto-open diff for file under cursor while moving
        auto_open_debounce_ms = 80, -- debounce window (ms) for the above
      },
    },
  },

  -- {
  --   "saghen/blink.cmp",
  --   opts = {
  --     keymap = {
  --       preset = "super-tab",
  --       -- ["<Tab>"] = {
  --       --   "snippet_forward",
  --       --   function() -- sidekick next edit suggestion
  --       --     return require("sidekick").nes_jump_or_apply()
  --       --   end,
  --       --   function() -- if you are using Neovim's native inline completions
  --       --     return vim.lsp.inline_completion.get()
  --       --   end,
  --       --   "fallback",
  --       -- },
  --     },
  --     completion = {
  --       ghost_text = {
  --         -- show_with_menu = false, -- only show when menu is closed
  --       },
  --       menu = {
  --         winblend = vim.o.pumblend,
  --       },
  --     },
  --     signature = {
  --       window = {
  --         winblend = vim.o.pumblend,
  --       },
  --     },
  --   },
  -- },
}
