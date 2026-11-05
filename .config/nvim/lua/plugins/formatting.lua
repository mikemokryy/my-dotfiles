-- Formatting (ported from dotfiles/dot_config/nvim).
--
-- LazyVim core already sets default_format_opts (timeout 3000, async=false,
-- quiet=false, lsp_format=fallback) and the lua/sh/fish formatters, so only the
-- JS/TS/web chain is added here.
--
-- Chain: oxfmt (only when the project opts in via an oxfmt config, `require_cwd`)
-- -> prettierd (only in projects with a prettier config, `require_cwd`)
-- -> prettier, via `stop_after_first`.
--
-- Markdown is intentionally left to LazyVim's lang.markdown extra so that
-- markdownlint-cli2 and markdown-toc keep running after prettier.
return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local chain = { "oxfmt", "prettierd", "prettier", stop_after_first = true }
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs({
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "css",
        "scss",
        "less",
        "html",
        "yaml",
      }) do
        opts.formatters_by_ft[ft] = vim.deepcopy(chain)
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.oxfmt = vim.tbl_deep_extend("force", opts.formatters.oxfmt or {}, {
        require_cwd = true,
      })

      -- prettierd resolves its cwd from prettier config files (or a package.json
      -- with a "prettier" key); require_cwd skips it in projects that did not opt
      -- in, honoring vim.g.lazyvim_prettier_needs_config = true.
      opts.formatters.prettierd = vim.tbl_deep_extend("force", opts.formatters.prettierd or {}, {
        require_cwd = true,
      })
    end,
  },
}
