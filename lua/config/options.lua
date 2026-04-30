local opts = vim.opt

-- Tab / Indentation
opts.tabstop = 2
opts.softtabstop = 2
opts.shiftwidth = 2
opts.expandtab = true
opts.smartindent = true
opts.relativenumber = false
opts.wrap = false

-- Search
opts.incsearch = true
opts.ignorecase = true
opts.smartcase = true
opts.hlsearch = true
-- opts.conceallevel = 2

-- Appearance
opts.number = true
opts.termguicolors = true
opts.signcolumn = "yes"
opts.colorcolumn = "100"
opts.clipboard = 'unnamedplus'
opts.cmdheight = 0
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

-- Deps for keymapper.nvim
local function escape(str)
  -- You need to escape these characters to work correctly
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

-- Recommended to use lua template string
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

vim.opt.langmap = vim.fn.join({
    -- | `to` should be first     | `from` should be second
    escape(ru_shift) .. ';' .. escape(en_shift),
    escape(ru) .. ';' .. escape(en),
}, ',')

