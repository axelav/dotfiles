set t_Co=256

" enabled later, after vundle
set filetype=off

let mapleader=","

set backspace=indent,eol,start
set clipboard+=unnamed
set cursorline
set encoding=utf-8 nobomb
set gdefault
set hidden
set history=1000
set ignorecase
set incsearch
set indentexpr=off
set laststatus=2
set nobackup
set noerrorbells
set nojoinspaces
set nohlsearch
set noshowcmd
set noshowmatch
set noswapfile
set nowritebackup
set number
set relativenumber
set ruler
set scrolloff=5
set secure
set shortmess=AITstW
set smartcase
set smarttab
set title
set timeoutlen=500
set ttyfast
set undofile
set undodir=~/.vim/undo
set wildchar=<tab>
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/vendor/*,*/bower_components/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/coverage/*
set wildignore+=*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*,*/.DS_Store
set wildmenu
set wildmode=longest,list,full
set nowrap

setlocal spell spelllang=en_us
set nospell

" vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/tComment'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'axelav/JavaScript-Indent'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'othree/html5.vim'
Plugin 'mattn/emmet-vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'vim-scripts/Auto-Pairs'
Plugin 'valloric/MatchTagAlways'
Plugin 'tpope/vim-surround'
Plugin 'qpkorr/vim-bufkill'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'lambdatoast/elm.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'jeetsukumaran/vim-filebeagle'
Plugin 'jeetsukumaran/vim-buffergator'


call vundle#end()

set background=dark
colorscheme base16-default
let base16colorspace=256

" use airline tab line
let g:airline#extensions#tabline#enabled = 1

" airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" enable/disable fugitive integration
let g:airline#extensions#branch#enabled = 1

" exclude fugitive panes from editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" always show dotfiles with command-t
let g:CommandTAlwaysShowDotFiles = 1

" disable auto pairs auto space insertion
let g:AutoPairsMapSpace = 0

" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction

" omnicompletion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" js libs to use with syntaxcomplete
let g:used_javascript_libs = 'underscore,lodash,react,backbone,jquery,angularjs,jasmine'

" format options
set filetype=on
filetype plugin on
filetype indent on

set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set textwidth=80

" enable syntax highlighting
syntax enable

" cycle through buffers
nmap <leader><tab> :bn<cr>
nmap <leader>` :bp<cr>

" close current buffer using bufkill (,q)
nmap <leader>q :BD<cr>

" close current buffer, ignoring changes (,q!)
nmap <leader>q! :bd!<cr>

" save current file (,w)
nmap <leader>w :w!<cr>

" text search current directory (,a)
nmap <leader>a :Ag!<space>

" fugitive
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gw :Gbrowse<cr>

" remap ctrl-j to split a line
nnoremap <nl> i <cr><esc>

" html
autocmd FileType html setlocal textwidth=0

" json
autocmd BufRead,BufNewFile *.json set syntax=javascript

" less
autocmd BufRead,BufNewFile *.less set ft=less

" strip trailing white space on save
autocmd FileType javascript autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType json autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType css autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType html autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType markdown autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType python autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType ruby autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType less autocmd BufWritePre <buffer> :%s/\s\+$//e

" open help in vertical split
autocmd FileType help wincmd L
