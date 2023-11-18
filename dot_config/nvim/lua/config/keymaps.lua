-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local ops = { noremap = true, silent = true }

keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

--Behave Vim: Yunk to the end of the line
keymap.set("n", "Y", "y$")

--Keeping it centered
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "J", "mzJ``z")

--Undo break points
keymap.set("i", ",", ",<c-g>u")
keymap.set("i", ".", ".<c-g>u")
keymap.set("i", "!", "!<c-g>u")
keymap.set("i", "?", "?<c-g>u")

vim.cmd([[
" Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>: .+1<CR>==
inoremap <C-k> <esc>: .-2<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
]])
