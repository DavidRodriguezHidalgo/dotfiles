vim.cmd([[
set number
set mouse=a
set numberwidth=1
set clipboard=unnamed 
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2

set laststatus=2
set noshowmode
set autoindent
set lazyredraw
set nohlsearch
set incsearch
set noswapfile
set hidden
set digraph
set list listchars=tab:··,trail:·
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set smartcase
set termguicolors
set scrolloff=8
set signcolumn=yes
"set completeopt=menuone,noselect
set completeopt=noinsert,menuone,noselect " Modifies the auto-complete menu to behave more like an IDE.
set cursorline " Highlights the current line in the editor

set cc=120 " Show at 120 column a border for good code style
set ttyfast " Speed up scrolling in Vim
]])

-- Use the space key as our leader.
vim.g.mapleader = " "
