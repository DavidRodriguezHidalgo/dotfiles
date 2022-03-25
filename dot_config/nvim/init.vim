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
set hlsearch
set digraph
set list listchars=tab:··,trail:·
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set termguicolors
"set completeopt=menuone,noselect
set completeopt=noinsert,menuone,noselect " Modifies the auto-complete menu to behave more like an IDE.
set cursorline " Highlights the current line in the editor

set cc=120 " Show at 120 column a border for good code style
set ttyfast " Speed up scrolling in Vim

call plug#begin('~/.vim/plugged')

" Themes
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'folke/tokyonight.nvim'

" IDE
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'sbdchd/neoformat'
Plug 'ThePrimeagen/harpoon'
" Use CTRL and hjkl to navigate in panes
Plug 'tveskag/nvim-blame-line'
Plug 'tpope/vim-commentary'

" Git
Plug 'TimUntersberger/neogit'
Plug 'nvim-lua/plenary.nvim'
Plug 'airblade/vim-gitgutter'

" Vim airline (bottom bar)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'slim-template/vim-slim'
Plug 'hrsh7th/nvim-compe'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
let g:airline_powerline_fonts = 1

call plug#end()

colorscheme gruvbox

autocmd BufEnter * EnableBlameLine

lua << EOF

require("telescope").load_extension('project')

EOF

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts) 
  buf_set_keymap('n', 'gc', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- install npm i -g vscode-langservers-extracted@lates
local servers = { "solargraph", "tsserver", "gopls", "yamlls", "cssls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
}
end
EOF

lua << EOF
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = false;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}
EOF
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR> compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })

" Use the space key as our leader.
let mapleader=" "

command! BufOnly execute '%bdelete|edit #|normal `"'

nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>t :Explore<CR>
nmap <Leader>r :%s/foo/bar/gci
nmap <Leader>f :Neoformat<CR>
nmap <Leader>m :lua require("harpoon.ui").toggle_quick_menu()<CR>
nmap <Leader>, :lua require("harpoon.ui").nav_prev()<CR>
nmap <Leader>. :lua require("harpoon.ui").nav_next()<CR>
nmap <Leader>- :lua require("harpoon.mark").add_file()<CR>
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
map <Leader>g :Neogit<cr>
" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdl :diffget //2<CR>
nnoremap gdr :diffget //3<CR>
" Find files using Telescope command-line sugar.
nnoremap <leader>p :Telescope project<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope current_buffer_fuzzy_find<cr>

" Behave Vim: Yunk to the end of the line
nnoremap Y y$

" Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ``z

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

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

let NERDTreeMapOpenInTab='v'

if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif

    let g:airline#extensions#tabline#enabled = 0
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#left_alt_sep = ''
    let g:airline#extensions#tabline#right_sep = ''
    let g:airline#extensions#tabline#right_alt_sep = ''
    let g:airline#extensions#tabline#formatter = 'default'

    " Theme ( github.com/vim-airline/vim-airline-themes
    let g:airline_theme= 'bubblegum'

