local wk = require('which-key')

wk.add({'<leader>cp', ":%!npx prettier --stdin-filepath %<CR>", desc = "format with prettier"})
wk.add({'<leader>cf', vim.lsp.buf.format, desc = "format with lsp"})
wk.add({'<C-d>', '<C-d>zz'})
wk.add({'<C-u>', '<C-d>zz'})
