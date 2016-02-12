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
set tabstop=2
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

setlocal spell spelllang=en_us
set nospell

set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
  au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12
endif

" plugins
" -------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'chriskempson/base16-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'gregsexton/gitv'
Plugin 'jeetsukumaran/vim-filebeagle'
Plugin 'lambdatoast/elm.vim'
Plugin 'mattn/emmet-vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'qpkorr/vim-bufkill'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'valloric/MatchTagAlways'
Plugin 'vim-scripts/Auto-Pairs'

call vundle#end()

" editorconfig
let g:EditorConfig_exclude_patterns=['fugitive://.*']

" filebeagle
let g:filebeagle_show_hidden=1

" autopairs
let g:AutoPairsMapSpace=0

" js libs syntax
let g:used_javascript_libs='jquery,underscore,lodash,react,backbone,angularjs,angularui,angularuirouter,jasmine'

" ctrlp
let g:ctrlp_show_hidden=1
let g:ctrlp_max_height=20
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_reversed=0

if executable('ag')
  let g:ctrlp_user_command='ag %s -l --nocolor --hidden -g ""'
endif

" bufkill
let g:BufKillCreateMappings=0

" theme
" -------------------------------------
let base16colorspace=256
set background=dark
colorscheme base16-default

syntax enable

" maps
" -------------------------------------
let mapleader=','

" search for currently open buffers with ctrlp
nmap <c-b> :CtrlPBuffer<cr>

" cycle through buffers
nmap <leader><tab> :bn<cr>
nmap <leader>` :bp<cr>

" close current buffer using bufkill
nmap <C-q> :BD<cr>

" close current buffer, ignoring changes
nmap <leader>q! :bd!<cr>

" save current file
nmap <leader>w :w!<cr>

" text search current working directory
nmap <leader>a :Ag!<space>

" use black hole register
nmap <leader>b "_

" fugitive
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gw :Gbrowse<cr>

" git stuff
map <leader>l :!clear && git log -p %<cr>
map <leader>d :!clear && git diff %<cr>

" map ctrl-j to split a line
nnoremap <nl> i <cr><esc>

" map . in visual mode
vnoremap . :norm.<cr>

" autocmds
" -------------------------------------
autocmd FileType html setlocal textwidth=0
autocmd FileType help wincmd L              " open help in vertical split
autocmd BufWritePre <buffer> :%s/\s\+$//e   " strip trailing white space on save
