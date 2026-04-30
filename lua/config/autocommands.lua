vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({})
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').scss = {
      install_info = {
        url = 'https://github.com/tree-sitter-grammars/tree-sitter-scss',
      },
    }
  end
})
