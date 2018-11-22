" plugins
" --------------------
call plug#begin('~/.vim/plugged')

Plug 'Alok/notational-fzf-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

call plug#end()

let g:goyo_width = 81
let g:nv_ignore_pattern = ['.git']
let g:nv_search_paths = ['~/Documents/notes']
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#quickfix_enabled = 0

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 240

" options
" --------------------
set nocompatible
set clipboard+=unnamed
set cursorline
set expandtab
set gdefault
set hidden
set lazyredraw
set list                   " show non-printing characters sometimes
set listchars+=eol:\ "     " show nothing at the end of a line
set listchars+=extends:›   " show a small chevron for text to the right
set listchars+=nbsp:␣      " show a small open box for non-breaking spaces
set listchars+=precedes:‹  " show a small chevron for text to the left
set listchars+=tab:›\ "    " show a small chevron for a tab
set listchars+=trail:·     " show a small interpunct for trailing whitespace
set listchars=             " clear defaults
set mouse=a
set nobackup
set nohlsearch
set nojoinspaces
set noswapfile
set nowritebackup
set number
set relativenumber
set shiftwidth=2
set smartcase
" set termguicolors
set softtabstop=2
set tabstop=2
set undofile

colorscheme desert

" maps
" --------------------
let mapleader=' '

nnoremap <leader>= <C-w>=
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :NV<cr>
nnoremap <leader>g :Goyo<cr>
nnoremap <leader>l :Limelight!!<cr>
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>
nnoremap <leader>q :close<cr>
nnoremap <leader>s :split<cr>
nnoremap <leader>t :FZF<cr>
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>z :set spell!<cr>

" functions
" --------------------
function! MarkdownEnter()
  setlocal linebreak
  setlocal spell
endfunction

" autocommands
" --------------------
autocmd BufWritePre *.js,*.ts,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync
" autocmd BufWritePre *.js,*.ts,*.css,*.less,*.scss,*.json,*.graphql,*.md PrettierAsync
autocmd BufWritePre,BufNewFile,BufReadPost *.md :call MarkdownEnter()
autocmd FileType gitcommit set textwidth=72
