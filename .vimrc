set t_Co=256

set nocompatible
set filetype=off

set autoindent
set backspace=indent,eol,start
set clipboard+=unnamed
set cursorline
set encoding=utf-8 nobomb
set expandtab
set gdefault
set hidden
set history=1000
set ignorecase
set incsearch
set indentexpr=off
set laststatus=2
set nobackup
set noerrorbells
set nohlsearch
set nojoinspaces
set noshowcmd
set noshowmatch
set noswapfile
set nowrap
set nowritebackup
set number
set relativenumber
set ruler
set scrolloff=5
set secure
set shiftwidth=2
set shortmess=AITstW
set smartcase
set smarttab
set softtabstop=2
set tabstop=2
set textwidth=80
set timeoutlen=500
set title
set ttyfast
set undodir=~/.vim/undo
set undofile
set wildchar=<tab>
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*,*/.DS_Store
set wildignore+=*/vendor/*,*/bower_components/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/coverage/*
set wildmenu
set wildmode=longest,list,full

setlocal spell spelllang=en_us
set nospell

" vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'axelav/JavaScript-Indent'
Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jeetsukumaran/vim-filebeagle'
Plugin 'lambdatoast/elm.vim'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'qpkorr/vim-bufkill'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'valloric/MatchTagAlways'
Plugin 'vim-scripts/Auto-Pairs'
Plugin 'vim-scripts/tComment'

call vundle#end()

set background=dark
colorscheme base16-default
let base16colorspace=256

set filetype=on
filetype plugin indent on
syntax enable

" airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#branch#enabled=1

if !exists('g:airline_symbols')
  let g:airline_symbols={}
endif

let g:airline_left_sep='»'
let g:airline_left_sep='▶'
let g:airline_right_sep='«'
let g:airline_right_sep='◀'
let g:airline_symbols.crypt='🔒'
let g:airline_symbols.linenr='␊'
let g:airline_symbols.linenr='␤'
let g:airline_symbols.linenr='¶'
let g:airline_symbols.branch='⎇'
let g:airline_symbols.paste='ρ'
let g:airline_symbols.paste='Þ'
let g:airline_symbols.paste='∥'
let g:airline_symbols.whitespace='Ξ'

" editorconfig
let g:EditorConfig_exclude_patterns=['fugitive://.*']

" filebeagle
let g:filebeagle_show_hidden=1

" autopairs
let g:AutoPairsMapSpace=0

" js libs syntax
let g:used_javascript_libs='underscore,lodash,react,backbone,jquery,angularjs,jasmine'

" ctrlp
let g:ctrlp_show_hidden=1

if executable('ag')
  let g:ctrlp_user_command='ag %s -l --nocolor --hidden -g ""'
endif

" maps
let mapleader=','

" search for currently open buffers with ctrlp
nmap <c-b> :CtrlPBuffer<cr>

" cycle through buffers
nmap <leader><tab> :bn<cr>
nmap <leader>` :bp<cr>

" close current buffer using bufkill
nmap <leader>q :BD<cr>

" close current buffer, ignoring changes
nmap <leader>q! :bd!<cr>

" save current file
nmap <leader>w :w!<cr>

" text search current directory
nmap <leader>a :Ag!<space>

" fugitive
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gw :Gbrowse<cr>

" remap ctrl-j to split a line
nnoremap <nl> i <cr><esc>

" autocmds
autocmd FileType html setlocal textwidth=0
autocmd BufRead,BufNewFile *.json set syntax=javascript
autocmd BufRead,BufNewFile *.less set ft=less
autocmd FileType help wincmd L " open help in vertical split
autocmd BufWritePre <buffer> :%s/\s\+$//e " strip trailing white space on save
