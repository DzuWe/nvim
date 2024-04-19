local wk = require('which-key')

wk.register({
  ['<leader>'] = {
    c = {
      name = '+code actions',
      ['='] = {'ggvG=<C-o>', 'Indent all'},
      f = {vim.lsp.buf.format, 'Format buffer'}
    }
  }
})
