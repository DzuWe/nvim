local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
require('vim-common') -- Common vim config

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup("plugins")
require('keymaps') -- keymapping
