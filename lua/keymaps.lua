local wk = require("which-key")

wk.register({
  c = {
    name = "+code actions",
    f = { vim.lsp.buf.format, "Format buffer" },
    c = {':%!npx prettier --stdin-filepath %<CR>', 'Try to format buffer with prettier'},
    y = { '"*y', "yank to clipboard"},
    p = { '"*p', "past from clipboard"}
  },
}, { prefix = "<leader>" })
