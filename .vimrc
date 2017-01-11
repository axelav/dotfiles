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
set nowrap
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
  au InsertLeave * hi StatusLine ctermfg=240 ctermbg=2
  au InsertEnter * hi StatusLine ctermbg=240 ctermfg=10
endif

" plugins
" -------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-sort-motion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'gregsexton/gitv', {'on': 'Gitv'}
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim'
Plug 'justinmk/vim-dirvish'
Plug 'lambdatoast/elm.vim', {'for': 'elm'}
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'mhinz/vim-grepper'
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'valloric/MatchTagAlways'
Plug 'vim-scripts/Auto-Pairs'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-syntastic/syntastic', {'for': 'javascript'}

call plug#end()

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
colorscheme base16-tomorrow-night

" autopairs
let g:AutoPairsMapSpace=0

" js libs syntax
let g:used_javascript_libs='jquery,underscore,lodash,react,backbone,angularjs,angularui,angularuirouter,jasmine'

" ctrlp
let g:ctrlp_show_hidden=1
let g:ctrlp_max_height=20
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_reversed=0

" jsx
let g:jsx_ext_required = 0

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
nnoremap <leader>a :Grepper -tool ag<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

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

" syntastic
function! SetSyntasticPrefs()
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

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
  " let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'

  let g:syntastic_error_symbol = '❌'
  let g:syntastic_style_error_symbol = '⁉️'
  let g:syntastic_warning_symbol = '⚠️'
  let g:syntastic_style_warning_symbol = '💩'

  highlight link SyntasticErrorSign SignColumn
  highlight link SyntasticWarningSign SignColumn
  highlight link SyntasticStyleErrorSign SignColumn
  highlight link SyntasticStyleWarningSign SignColumn
endfunction

autocmd FileType javascript call SetSyntasticPrefs()
