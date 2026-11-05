-- M is Meta key (Control)

return {
  -- Quickly jump to any location in the visible buffer
  {
    "folke/flash.nvim",
    enabled = false,
  },

  -- File explorer (provided by LazyVim's editor.neo-tree extra,
  -- selected via `vim.g.lazyvim_explorer` in config/options.lua)
  {
    "nvim-neo-tree/neo-tree.nvim",
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

  -- snacks: lazygit integration disabled (lazygit runs outside Neovim)
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = { enabled = false },
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
        width = 50,
        auto_open_on_cursor = true, -- auto-open diff for file under cursor while moving
        auto_open_debounce_ms = 80, -- debounce window (ms) for the above
        view_mode = "tree", -- "list" or "tree"
        line_stats = {
          enabled = true,
        },
      },
      diff = {
        compact = true,
        compact_context_lines = 8,
        compact_sync_folds = true, -- open/close folds in both panes together
      },
    },
  },

  -- Treesitter parsers (extends LazyVim's ensure_installed list)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "swift" } },
  },

  -- LaTeX support
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
      vim.g.vimtex_compiler_method = "tectonic"

      -- Configure tectonic lazily: only when a .tex file is opened. Doing the
      -- git lookup and creating <repo>/build at every startup would run in
      -- unrelated repositories and create build/ dirs for no reason.
      -- BufReadPre/BufNewFile run before the tex ftplugin calls vimtex#init().
      local configured = {}

      local function setup_tectonic()
        local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
        local root = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })[1]

        if vim.v.shell_error == 0 and root and root ~= "" then
          if not configured[root] then
            vim.fn.mkdir(root .. "/build", "p") -- tectonic does not create it
            configured[root] = true
          end
          vim.g.vimtex_compiler_tectonic = {
            out_dir = root .. "/build",
            options = { "--keep-logs", "--synctex" },
          }
        else
          vim.g.vimtex_compiler_tectonic = {
            out_dir = "build",
            options = { "--keep-logs", "--synctex" },
          }
        end
      end

      vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup("UserVimtexTectonic", { clear = true }),
        pattern = { "*.tex" },
        callback = setup_tectonic,
      })
    end,
  },
}
