vim.opt.termguicolors = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.splitright = true
vim.o.shiftwidth = 2
vim.o.cmdheight = 0

vim.o.expandtab = true
vim.o.number = true

vim.g.mapleader = " "

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function() vim.highlight.on_yank({}) end,
})
