vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.numberwidth = 1
vim.opt.clipboard='unnamed' 
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.encoding = 'utf-8'
vim.opt.showmatch = true
vim.opt.sw = 2
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.autoindent = true
vim.opt.lazyredraw = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.digraph = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.cursorline = true
vim.opt.ttyfast = true
vim.cmd([[
set list listchars=tab:··,trail:·
set signcolumn=yes
set completeopt=noinsert,menuone,noselect " Modifies the auto-complete menu to behave more like an IDE.

set cc=120 " Show at 120 column a border for good code style
]])

-- Use the space key as our leader.
vim.g.mapleader = " "
