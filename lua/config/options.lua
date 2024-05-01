local opts = vim.opt

-- Tab / Indentation
opts.tabstop = 2
opts.softtabstop = 2
opts.shiftwidth = 2
opts.expandtab = true
opts.smartindent = true
opts.wrap = false

-- Search
opts.incsearch = true
opts.ignorecase = true
opts.smartcase = true
opts.hlsearch = true

-- Appearance
opts.number = true
opts.relativenumber = true
opts.termguicolors = true
opts.signcolumn = "yes"
opts.colorcolumn = "100"
opts.cmdheight = 1
opts.scrolloff = 10
opts.completeopt = "menuone,noinsert,noselect"

-- Behaviour
opts.hidden = true
opts.errorbells = false
opts.mouse = "a"
opts.swapfile = false
opts.backup = false
opts.undodir = vim.fn.expand("~/.vim/undodir")
opts.undofile = true
opts.updatetime = 300
opts.timeoutlen = 500
opts.signcolumn = "yes"
opts.backspace = "indent,eol,start"
opts.splitright = true
opts.splitbelow = true
opts.autochdir = false
opts.showmode = false

-- Folds
opts.foldmethod = "expr"
opts.foldexpr = "nvim_treesitter#foldexpr()"
opts.foldlevel = 99
