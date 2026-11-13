-- OpenCode opens its prompt in an embedded Neovim (`nvim --embed`) backed by
-- <tmpdir>/<epoch-ms>.md, with your own config.
--
-- OpenCode's input parser folds a fast <Esc> followed by h/j/k/l into
-- <A-h>/<A-j>/<A-k>/<A-l>. LazyVim maps <A-j>/<A-k> to "move line down/up" and
-- Copilot accepts a suggestion on <A-l>, so leaving insert mode and immediately
-- navigating moved lines or inserted text. In prompt buffers, map the merged
-- keys back to the motions they were meant to be.
local tmpdirs = {}
for _, dir in ipairs({ vim.uv.os_tmpdir(), vim.uv.fs_realpath(vim.uv.os_tmpdir()) }) do
  if dir then
    tmpdirs[vim.fs.normalize(dir)] = true
  end
end

local function is_prompt(buf)
  local name = vim.fs.normalize(vim.api.nvim_buf_get_name(buf))
  return name:match("/%d+%.md$") ~= nil and tmpdirs[vim.fs.dirname(name)] == true
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  callback = function(args)
    if not is_prompt(args.buf) then
      return
    end
    for _, motion in ipairs({ "h", "j", "k", "l" }) do
      vim.keymap.set({ "n", "i", "v" }, "<A-" .. motion .. ">", "<Esc>" .. motion, {
        buffer = args.buf,
        desc = "Motion (OpenCode merges <Esc>" .. motion .. " into this key)",
      })
    end
  end,
})
