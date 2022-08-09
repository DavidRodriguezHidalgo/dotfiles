local nnoremap = require("denzil.keymap").nnoremap
local nmap = require("denzil.keymap").nmap
local inoremap = require("denzil.keymap").inoremap
local vnoremap = require("denzil.keymap").vnoremap

nmap("<leader>s", "<Plug>(easymotion-s2)")
nmap("<leader>tt", ":NvimTreeToggle<CR>")
nmap("<Leader>t", ":NvimTreeFindFile<CR>")
nmap("<Leader>r", ":%s/foo/bar/gci")
nmap("<Leader>f", ":Neoformat<CR>")
nmap("<Leader>w", ":w<CR>")
nmap("<Leader>q", ":q<CR>")
nmap("<Leader>g", ":Neogit<cr>")

vim.cmd([[
inoremap <silent><expr> <C-Space> compe#complete()
nmap <Leader>m :lua require("harpoon.ui").toggle_quick_menu()<CR>
nmap <Leader>, :lua require("harpoon.ui").nav_prev()<CR>
nmap <Leader>. :lua require("harpoon.ui").nav_next()<CR>
nmap <Leader>- :lua require("harpoon.mark").add_file()<CR>
]])

nnoremap("<leader>gd", ":Gvdiffsplit!<CR>")
nnoremap("gdl", ":diffget //2<CR>")
nnoremap("gdr", ":diffget //3<CR>")
--Find files using Telescope command-line sugar.
nnoremap("<leader>p", ":Telescope project<CR>")
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nnoremap("<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>")

--Behave Vim: Yunk to the end of the line
nnoremap("Y", "y$")
nnoremap("x", '"_x')
nnoremap("d", '"_d')
-- delete word backwards
nnoremap("dw", 'vb"_d')
nnoremap("<C-a>", "gg<S-v>G")

--Keeping it centered
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ``z")

--Undo break points
inoremap(",", ",<c-g>u")
inoremap(".", ".<c-g>u")
inoremap("!", "!<c-g>u")
inoremap("?", "?<c-g>u")

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
