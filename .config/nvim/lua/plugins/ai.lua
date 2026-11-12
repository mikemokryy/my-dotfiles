-- LazyVim's extra already sets auto_trigger, `accept = false` (blink's
-- `ai_accept` action accepts with <Tab>), next/prev, panel and filetypes
return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
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
