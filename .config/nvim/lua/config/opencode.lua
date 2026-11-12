-- OpenCode opens its prompt in $EDITOR as <tmpdir>/<epoch-ms>.md.
--
-- A normal markdown buffer is fine, but a scratch prompt is not a real
-- document: it usually contains one or a few very long lines, and it lives in
-- $TMPDIR without a project root. Treating it as markdown makes LazyVim load
-- render-markdown/marksman, enables wrap+spell, and lets marksman fall back to
-- indexing $HOME. That makes mode switches reflow wrapped rows (so j/k jumps)
-- and makes typing lag.
--
-- Give OpenCode prompts a dedicated filetype. It still gets treesitter markdown
-- highlighting, but does not inherit markdown ftplugins, LSP servers,
-- renderers, linters, formatters, spell checking, wrapping or folds.
local prompt_filetype = "opencode_prompt"

local tmpdirs = {}
for _, dir in ipairs({ vim.uv.os_tmpdir(), vim.uv.fs_realpath(vim.uv.os_tmpdir()) }) do
  if dir then
    tmpdirs[vim.pesc(vim.fs.normalize(dir)) .. "/%d+%.md"] = prompt_filetype
  end
end

vim.filetype.add({ pattern = tmpdirs })

-- nvim-treesitter uses this mapping to highlight the prompt as markdown.
vim.treesitter.language.register("markdown", prompt_filetype)

local group = vim.api.nvim_create_augroup("UserOpencodePrompt", { clear = true })

local function apply(buf)
  if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].filetype ~= prompt_filetype then
    return
  end

  -- Buffer-local: no completion popups and no undo/swap files for prompts.
  vim.b[buf].completion = false
  vim.bo[buf].undofile = false
  vim.bo[buf].swapfile = false

  -- Window-local: render plain text with a stable viewport. This overrides
  -- LazyVim's treesitter folds and the global wrap/smoothscroll/scrolloff.
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    if vim.api.nvim_win_is_valid(win) then
      vim.wo[win].wrap = false
      vim.wo[win].smoothscroll = false
      vim.wo[win].conceallevel = 0
      vim.wo[win].concealcursor = ""
      vim.wo[win].foldenable = false
      vim.wo[win].foldmethod = "manual"
      vim.wo[win].spell = false
      vim.wo[win].scrolloff = 3
      vim.wo[win].sidescrolloff = 1
      vim.wo[win].signcolumn = "no"
    end
  end
end

vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  group = group,
  callback = function(args)
    if vim.bo[args.buf].filetype ~= prompt_filetype then
      return
    end
    -- FileType handlers (ftplugins, LazyVim treesitter, ...) run during this
    -- event, so defer until they have finished before overriding window opts.
    vim.schedule(function()
      apply(args.buf)
    end)
  end,
})
