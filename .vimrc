" http://vimdoc.sourceforge.net/htmldoc/help.html

" Make Vim more useful
set nocompatible

" Set colorscheme
set t_Co=256
colorscheme Tomorrow-Night

" Enabled later, after Vundle
filetype off

" Change mapleader
let mapleader=","

" Centralize backups, swapfiles and undo history
set backup
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Set a bunch of stuff
set ai                                " Auto indent
set autoindent                        " Copy indent from last line when starting new line.
set backspace=indent,eol,start        " Allow backspace in insert mode
set binary
set cursorline                        " Highlight current line
set encoding=utf-8 nobomb             " Use UTF-8 without BOM
set esckeys                           " Allow cursor keys in insert mode
set expandtab                         " Expand tabs to spaces
set exrc                              " Enable per-directory .vimrc files and disable unsafe commands in them
set nofoldenable                      " no folds!
set formatoptions+=c                  " Format comments
set formatoptions+=n                  " Recognize numbered lists
set formatoptions+=l                  " Don't break lines that are already long
set formatoptions+=1                  " Break before 1-letter words
set gdefault                          " Add the g flag to search/replace by default
set hidden                            " When a buffer is brought to foreground, remember undo history & marks
set history=1000                      " Increase history from 20 to 1000
set hlsearch                          " Highlight searches
set ignorecase                        " Ignore case of searches
set incsearch                         " Highlight dynamically as pattern is typed
set laststatus=2                      " Always show status line
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_  " Show “invisible” characters
set list
set mouse=a                           " Enable mouse in all modes
set noerrorbells                      " Disable error bells
set nostartofline                     " Don't reset cursor to start of line when moving around.
set number                            " Enable line numbers
set ruler                             " Show the cursor position
set scrolloff=10                      " Start scrolling five lines before the horizontal window border
set secure
set shiftwidth=2                      " The number of spaces to indent
set shortmess=atI                     " Don't show the intro message when starting Vim
set showcmd                           " Show the (partial) command as it’s being typed
set showmatch                         " Show matching parenthesis
set showmode                          " Show the current mode
set si                                " Smart indent
set smartcase                         " when searching try to be smart about cases
set smarttab                          " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.
set tabstop=2                         " Make tabs as wide as four spaces
set softtabstop=2                     " Make the spaces feel like real tabs
set title                             " Show the filename in the window titlebar
set ttyfast                           " Optimize for fast terminal connections
set undofile                          " Persistent undo
set wildchar=<tab>                    " Character for CLI expansion (TAB-completion).
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/vendor/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/doc/*,*/.DS_Store
set wildmenu                          " Enhance command-line completion
set wildmode=longest,list,full
set wrap                              " Wrap lines

" Set a column at 100 characters for text alignment
" http://vimdoc.sourceforge.net/htmldoc/options.html#%27colorcolumn%27
if exists('+colorcolumn')
  set colorcolumn=100
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
endif

" Use the OS X clipboard if not using tmux
if $TMUX == ''
  set clipboard+=unnamed
endif

" Use relative line numbers
if exists("&relativenumber")
  set relativenumber
  au BufReadPost,BufNewFile * set relativenumber
endif

" Vundle config
" https://github.com/gmarik/vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" My Bundles
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mattn/emmet-vim'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/Auto-Pairs'
Plugin 'airblade/vim-gitgutter'
Plugin 'wincent/command-t'
Plugin 'tpope/vim-fugitive'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'ervandew/supertab'
Plugin 'rking/ag.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'valloric/MatchTagAlways'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'gcmt/wildfire.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-obsession'
Plugin 'Shougo/neocomplete.vim'

call vundle#end()

" Use airline tab line
let g:airline#extensions#tabline#enabled = 1

" Always show dotfiles with command-t
let g:CommandTAlwaysShowDotFiles = 1

" Override vim's global ignore list
let g:CommandTWildIgnore='*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js,*/vendor/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/build/*,*/bin/*,*/doc/*'

" Disable auto pairs auto space insertion
let g:AutoPairsMapSpace = 0

" Javascript libraries to use with SyntaxComplete
let g:used_javascript_libs = 'underscore,backbone,jquery,lodash,angularjs,jasmine'

" Enable file type detection, plugins, indent
filetype plugin indent on

" Enable syntax highlighting
syntax enable

" Strip trailing whitespace (,ss)
function! <SID>StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<cr>

" Cycle through buffers
nmap <leader><tab> :bn<cr>
nmap <leader>` :bp<cr>

" Exit insert mode
imap jj <esc>

" Close current buffer (,q)
nmap <leader>q :bd<cr>

" Close current buffer, ignoring changes (,q!)
nmap <leader>q! :bd!<cr>

" Close current buffer w/o closing split (,d)
nmap <leader>d :b#<bar>bd#<cr>

" Display buffer list & choose a buffer (,b)
" nnoremap <leader>b :ls<cr>:buffer<space>

" Save current file (,w)
nmap <leader>w :w!<cr>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<cr>

" Toggle paste mode on & off
nmap <leader>pp :setlocal paste!<cr>

" Turn off search highlighting (,hl)
noremap <leader>hl :nohlsearch<cr>

" Vertical split (,vs)
nmap <leader>vs :vsplit<cr>

" Horizontal split (,hs)
nmap <leader>hs :split<cr>

" Text search current directory (,f)
nmap <leader>f :Ag!<space>

" NERDTree
nmap <leader>n :NERDTree<cr>

" Remap VIM 0 to first non-blank character
map 0 ^

" Remap ctrl-j to split a line
nnoremap <nl> i <cr><esc>

" Automatic commands

" edit & reload .vimrc within vim
" map <leader>vimrc :tabe ~/.vimrc<cr>
" autocmd bufwritepost .vimrc source $MYVIMRC

" Treat .json files as .js
au BufRead,BufNewFile *.json set ft=json syntax=javascript

" Treat .geojson files as .js
au BufRead,BufNewFile *.geojson set ft=json syntax=javascript

" Jade
au BufRead,BufNewFile *.jade set ft=jade syntax=jade

" EJS
au BufRead,BufNewFile *.ejs set ft=html syntax=html

" Jinja
au BufReadPost *.tpl set ft=html syntax=html

" Markdown
au BufRead,BufNewFile *.md set ft=markdown

" LESS
au BufRead,BufNewFile *.less set ft=less

" Coffeescript
au BufRead,BufNewFile *.coffee set ft=coffee

" Git commit settings
au Filetype gitcommit setlocal spell textwidth=72

" Strip trailing white space on save
autocmd FileType javascript,coffee,ruby,python,html,css,less,markdown autocmd BufWritePre <buffer> :call <SID>StripWhitespace()

" EasyMotion mapping
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump anywhere (s{char}{char}{label})
nmap s <Plug>(easymotion-s2)

" Make EasyMotion case sensitive
let g:EasyMotion_smartcase = 1

" Line motions (j/k)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
