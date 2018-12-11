" plugins
" --------------------
call plug#begin('~/.vim/plugged')

Plug 'Alok/notational-fzf-vim'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
Plug 'mhinz/vim-grepper'
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'w0rp/ale'

call plug#end()

" options
" --------------------
set nocompatible
set clipboard+=unnamed
set cursorline
set expandtab
set foldenable
set foldlevel=99            " don't autofold anything
set foldlevelstart=99       " don't autofold anything
set foldmethod=syntax
set foldtext=FoldText()
set gdefault
set hidden
set ignorecase
set lazyredraw
set list                    " show non-printing characters sometimes
set listchars+=eol:\ "      " show nothing at the end of a line
set listchars+=extends:›    " show a small chevron for text to the right
set listchars+=nbsp:␣       " show a small open box for non-breaking spaces
set listchars+=precedes:‹   " show a small chevron for text to the left
set listchars+=tab:›\ "     " show a small chevron for a tab
set listchars+=trail:·      " show a small interpunct for trailing whitespace
set mouse=a
set nobackup
set nohlsearch              " use <C-L> to clear highlighting
set nojoinspaces
set noswapfile
set nowritebackup
" set number
" set relativenumber
set shiftwidth=2
set smartcase
set softtabstop=2
set spellcapcheck=
set tabstop=2
set termguicolors
set undofile

let g:goyo_width = 81
let g:netrw_altfile = 1
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" let g:netrw_list_hide = netrw_gitignore#Hide().'\(^\|\s\s\)\zs\.\S\+'
let g:netrw_preview = 1
let g:netrw_winsize = 30
let g:nv_ignore_pattern = ['.git']
let g:nv_search_paths = ['~/Documents/notes']
let g:pencil#wrapModeDefault = 'soft'
let g:prettier#autoformat = 0
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#quickfix_enabled = 0
let mapleader = ' '


" colors
" --------------------
" colorscheme desert
colorscheme base16-atelier-savanna

" maps
" --------------------

nnoremap - :Explore<cr>
nnoremap <leader>= <C-w>=
nnoremap <leader>a :Grepper -tool rg -grepprg rg -H --no-heading --hidden --follow --glob "!.git/*" --vimgrep <cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>c :cclose<cr>
nnoremap <leader>d :!vmd % &<cr>
nnoremap <leader>f :NV<cr>
nnoremap <leader>g :Goyo<cr>
nnoremap <leader>h :set hls!<cr>
nnoremap <leader>j :bn<cr>
nnoremap <leader>k :bp<cr>
nnoremap <leader>l :call LimelightToggle()<cr>
nnoremap <leader>n :set number! relativenumber!<cr>
nnoremap <leader>p <C-w>z
nnoremap <leader>q :close<cr>
nnoremap <leader>s :split<cr>
nnoremap <leader>t :FZF<cr>
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>z :set spell! spelllang=en_us<cr>
nnoremap Y y$

" functions
" --------------------
function! MarkdownEnter()
  setlocal linebreak
endfunction

function! LimelightToggle()
  setlocal nocursorline!
  setlocal nospell
  Limelight!!
endfunction

" https://github.com/emilyst/home/blob/7da06268baf58d4a5b2e6ef78304f1dfa00fa690/.vimrc#L246
function! FoldText()
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart(' ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction

" autocommands
" --------------------
" autocmd BufWritePre *.js,*.ts,*.css,*.less,*.scss,*.json,*.graphql,*.md PrettierAsync
autocmd BufWritePre *.js,*.ts,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync
autocmd BufNewFile,BufReadPost *.md :call MarkdownEnter()
autocmd FileType gitcommit set textwidth=72
autocmd FileType markdown,mkd,text call pencil#init()
