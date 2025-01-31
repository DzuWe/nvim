local wk = require("which-key")

wk.add({
  { "<leader>c",  group = "+code actions" },
  { "<leader>cf", vim.lsp.buf.format,                       desc = "Format buffer" },
  { "<leader>cc", ":%!npx prettier --stdin-filepath %<CR>", desc = "Try to format buffer with prettier" },
  { "<leader>cy", '"*y',                                    desc = "yank to clipboard" },
  { "<leader>cp", '"*p',                                    desc = "past from clipboard" },
})
