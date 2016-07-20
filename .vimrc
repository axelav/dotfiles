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
call plug#begin('~/.vim/plugged')

Plug 'FooSoft/vim-argwrap', {'on': 'ArgWrap'}
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-sort-motion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'gregsexton/gitv', {'on': 'Gitv'}
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim'
Plug 'justinmk/vim-dirvish'
Plug 'lambdatoast/elm.vim', {'for': 'elm'}
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript', {'branch': 'develop'}
Plug 'rking/ag.vim', {'on': 'Ag'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'valloric/MatchTagAlways'
Plug 'vim-scripts/Auto-Pairs'
Plug 'vim-scripts/ReplaceWithRegister'

call plug#end()

" editorconfig
let g:EditorConfig_exclude_patterns=['fugitive://.*']

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

" jsx
let g:jsx_ext_required = 0

" theme
" -------------------------------------
set background=dark
colorscheme tomorrow-night

syntax enable

" maps
" -------------------------------------
let mapleader=' '

" search for currently open buffers with ctrlp
nmap <c-b> :CtrlPBuffer<cr>

" cycle through buffers
nmap <leader><tab> :bn<cr>
nmap <leader>` :bp<cr>

" close current buffer, ignoring changes
nmap <leader>q! :bd!<cr>

" save current file
nmap <leader>w :w!<cr>

" text search current working directory
nmap <leader>a :Ag!<space>

" use black hole register
nmap <leader>b "_

" fugitive
nnoremap <leader>gb :Gblame<cr>

" git stuff
map <leader>s :!clear && git status -s %<cr>
map <leader>l :!clear && git log -p %<cr>
map <leader>d :!clear && git diff %<cr>

" map ctrl-j to split a line
nnoremap <nl> i <cr><esc>

" map . in visual mode
vnoremap . :norm.<cr>

" elm stuff
" https://github.com/lambdatoast/elm.vim
nnoremap <leader>el :ElmEvalLine<CR>
vnoremap <leader>es :<C-u>ElmEvalSelection<CR>
nnoremap <leader>em :ElmMakeCurrentFile<CR>

" autocmds
" -------------------------------------
autocmd FileType html setlocal textwidth=0
autocmd FileType help wincmd L              " open help in vertical split
autocmd BufWritePre <buffer> :%s/\s\+$//e   " strip trailing white space on save

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

autocmd FileType dirvish sort ir /^.*[^\/]$/
