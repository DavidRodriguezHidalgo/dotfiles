local nnoremap = require("denzil.keymap").nnoremap
local nmap = require("denzil.keymap").nmap
local inoremap = require("denzil.keymap").inoremap
local vnoremap = require("denzil.keymap").vnoremap

nnoremap("<leader>t", ":NvimTreeFindFile <CR>")
nnoremap("<leader>tt", ":NvimTreeToggle <CR>")
nmap("<Leader>f", ":Neoformat<CR>")
nmap("<Leader>w", ":w<CR>")
nmap("<Leader>q", ":q<CR>")

vim.cmd([[
inoremap <silent><expr> <C-Space> compe#complete()
nmap <Leader>m :lua require("harpoon.ui").toggle_quick_menu()<CR>
nmap <Leader>, :lua require("harpoon.ui").nav_prev()<CR>
nmap <Leader>. :lua require("harpoon.ui").nav_next()<CR>
nmap <Leader>- :lua require("harpoon.mark").add_file()<CR>
]])

--Find files using Telescope command-line sugar.
nnoremap("<leader>p", ":Telescope project<CR>")
nnoremap("<leader>g", ":Neogit <CR>")
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nnoremap("<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
nnoremap("gb", "<cmd>:BufferLinePick<CR>")
nnoremap("bd", "<cmd>:BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>")
--Behave Vim: Yunk to the end of the line
nnoremap("Y", "y$")

--Keeping it centered
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ``z")

--Undo break points
inoremap(",", ",<c-g>u")
inoremap(".", ".<c-g>u")
inoremap("!", "!<c-g>u")
inoremap("?", "?<c-g>u")

-- New tab
nnoremap("te", "<cmd>:tabedit<CR>")

-- Split window
nnoremap("ss", "<cmd>:split<Return><C-w>w<CR>")
nnoremap("sv", "<cmd>:vsplit<Return><C-w>w<CR>")

-- Move window
nnoremap("sh", "<C-w>h")
nnoremap("sk", "<C-w>k")
nnoremap("sj", "<C-w>j")
nnoremap("sl", "<C-w>l")

-- Resize window
nnoremap("<C-w><left>", "<C-w><")
nnoremap("<C-w><right>", "<C-w>>")
nnoremap("<C-w><up>", "<C-w>+")
nnoremap("<C-w><down>", "<C-w>-")

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
