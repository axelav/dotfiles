" plugins
" -------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'airblade/vim-gitgutter'
Plug 'blueyed/vim-diminactive'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-sort-motion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'gregsexton/gitv', {'on': 'Gitv'}
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
Plug 'justinmk/vim-dirvish'
Plug 'ledger/vim-ledger', {'for': 'ledger'}
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-grepper'
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'othree/javascript-libraries-syntax.vim', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-syntastic/syntastic', {'for': ['javascript', 'javascript.jsx', 'jsx']}
" Plug 'tpope/vim-fugitive'

call plug#end()

" ledger
let g:ledger_maxwidth = 80
let g:ledger_fold_blanks = 1

" dont syntax highlight inactive buffers
let g:diminactive_use_syntax = 1

" js libs syntax
let g:used_javascript_libs='lodash,react'

" ctrlp
let g:ctrlp_show_hidden=1
let g:ctrlp_max_height=20
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_reversed=0

" jsx
let g:jsx_ext_required = 0

" options
" -------------------------------------
set t_Co=256
set nocompatible
set filetype=off

set clipboard+=unnamed
set cursorline
set expandtab
set gdefault
set hidden
set ignorecase
set indentexpr=off
set nobackup
set noerrorbells
set nohlsearch
set nojoinspaces
set noshowcmd
set noshowmatch
set nospell
set noswapfile
set nowrap
set nowritebackup
set number
set relativenumber
set scrolloff=5
set secure
set shiftwidth=2
set shortmess=AITstW
set smartcase
set softtabstop=2
set statusline=%F%m%r%h%w\ [%l,%c]\ [%L,%p%%]
set tabstop=2
set termguicolors
set textwidth=80
set title
set ttyfast
set undodir=~/.vim/undo
set undofile
set wildchar=<tab>
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*,*/.DS_Store
set wildignore+=*/vendor/*,*/bower_components/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/coverage/*
set wildmode=longest,list,full

colorscheme base16-tomorrow
syntax enable

" maps
" -------------------------------------
let mapleader=' '

" search for currently open buffers with ctrlp
nmap <c-b> :CtrlPBuffer<cr>

" save current file
nmap <leader>w :w!<cr>

" toggle highlight search
nmap <leader>h :set hlsearch!<cr>

" text search current working directory
nnoremap <leader>a :Grepper -tool ag<cr>

" use black hole register
nmap <leader>b "_

" map ctrl-j to split a line
nnoremap <nl> i <cr><esc>

" map . in visual mode
vnoremap . :norm.<cr>

" save file as sudo
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %

" autocmds
" -------------------------------------
" modify statusline color when in insert/normal mode
autocmd InsertEnter,InsertLeave * set cursorline!

autocmd FileType html setlocal textwidth=0
autocmd FileType help wincmd L              " open help in vertical split
autocmd BufWritePre <buffer> :%s/\s\+$//e   " strip trailing white space on save

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

autocmd FileType dirvish sort ir /^.*[^\/]$/

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
  let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
  let g:syntastic_javascript_eslint_exec = local_eslint
endif
