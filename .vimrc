" plugins
" -------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'LeonB/vim-nginx', { 'for': 'nginx' }
Plug 'Raimondi/delimitMate'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/csv.vim', {'for': 'csv'}
Plug 'chriskempson/base16-vim'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
Plug 'justinmk/vim-dirvish'
Plug 'ledger/vim-ledger', {'for': 'ledger'}
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-grepper'
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'tikhomirov/vim-glsl', {'for': 'glsl'}
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-syntastic/syntastic', {'for': ['javascript', 'javascript.jsx', 'jsx']}

call plug#end()

" deoplete
let g:deoplete#enable_at_startup = 1

" dirvish
let g:dirvish_mode = ':sort r /[^\/]$/'
" let g:dirvish_mode = 2

" jsx
let g:jsx_ext_required = 0

let g:user_emmet_install_global = 0

let g:user_emmet_settings = {'javascript.jsx' : {'extends' : 'jsx'}}

let g:goyo_width = 81

" ledger
let g:ledger_maxwidth = 80
let g:ledger_fold_blanks = 1

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
set mouse=a
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
set statusline=%F%m%r%h%w\ [%l,%c]\ [%L,%p%%]\ %{fugitive#statusline()}
set tabstop=2
set termguicolors
set textwidth=80
set title
set undodir=~/.vim/undo
set undofile
set wildchar=<tab>
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*,*/.DS_Store
set wildignore+=*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/coverage/*,*/yarn.lock
set wildignorecase
set wildmode=longest,list,full

colorscheme base16-tomorrow-night
syntax enable

cabbr <expr> %% fnameescape(expand('%:p:h'))

" maps
" -------------------------------------
let mapleader=' '

" save current file
nmap <leader>w :w!<cr>

" save file as sudo
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %

" toggle highlight search
nmap <leader>h :set hlsearch!<cr>

" open netrw
" nmap <leader>d :e .<cr>

" recursively find file in directory
nmap <leader>o :n **/*

" find file in current file's directory
nmap <leader>c :n %%/

" text search current working directory
nnoremap <leader>a :Grepper -tool ag<cr>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" use black hole register
nmap <leader>b "_

" map ctrl-j to split a line
nnoremap <nl> i <cr><esc>

" map . in visual mode
vnoremap . :norm.<cr>

" autocmds
" -------------------------------------
autocmd FileType html setlocal textwidth=0
autocmd FileType help wincmd L              " open help in vertical split
autocmd BufWritePre <buffer> :%s/\s\+$//e   " strip trailing white space on save

autocmd FileType html,css,javascript.jsx EmmetInstall
autocmd FileType gitcommit set textwidth=72

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

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
