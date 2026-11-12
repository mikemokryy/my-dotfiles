-- LazyVim's extra already sets auto_trigger, `accept = false` (blink's
-- `ai_accept` action accepts with <Tab>), next/prev, panel and filetypes
return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      -- Copilot already ignores `markdown`; make it ignore OpenCode's prompt
      -- filetype too so it does not try to complete in that scratch buffer.
      filetypes = {
        opencode_prompt = false,
      },
      suggestion = {
        keymap = {
          accept_word = "<M-l>",
          accept_line = "<M-S-l>",
          dismiss = "<C-]>",
        },
      },
    },
  },
}
