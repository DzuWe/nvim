local wk = require("which-key")

wk.add({
  { "<leader>c",  group = "+code actions" },
  { "<leader>cf", vim.lsp.buf.format,                       desc = "Format buffer" },
  { "<leader>cc", ":%!npx prettier --stdin-filepath %<CR>", desc = "Try to format buffer with prettier" },
  { "<leader>cy", '"*yy',                                   desc = "yank to clipboard" },
  { "<leader>cd", '"*dd',                                   desc = "cut to clipboard" },
  { "<leader>cp", '"*p',                                    desc = "past from clipboard" },
  { "<C-d>",      "<C-d>zz",                                desc = "page down and center screen" },
  { "<C-u>",      "<C-u>zz",                                desc = "page up and center screen" },
})

wk.add({
  {"<leader>c", group = "+code actions", mode = "v" },
  {"<leader>cy", '"*y', desc = "yank to clipboard",  mode = "v"},
  {"<leader>cd", '"*d', desc = "cut to clipboard",  mode = "v"},
  {"<leader>cp", '"*p', desc = "paste to clipboard",  mode = "v"},
})
