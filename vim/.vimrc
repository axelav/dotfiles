" plugins
call plug#begin('~/.vim/plugged')

Plug 'Alok/notational-fzf-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'maxmellon/vim-jsx-pretty', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'mhinz/vim-grepper'
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'plasticboy/vim-markdown'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'dense-analysis/ale'

Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'jxnblk/vim-mdx-js', {'for': ['mdx']}

call plug#end()

" plugin settings
let g:dirvish_mode = 'call DirvishSetup()'
let g:nv_ignore_pattern = ['.git']
let g:nv_search_paths = ['~/Documents/notes']
let g:prettier#autoformat = 0
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#quickfix_enabled = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_strikethrough = 1

let g:goyo_height = '100%'
let g:goyo_width = 101

" colors
syntax on
colorscheme desert

highlight Search ctermbg=LightGrey
highlight Search ctermfg=Black
highlight Visual cterm=reverse ctermbg=NONE
highlight DiffAdd cterm=reverse ctermbg=NONE
highlight DiffChange cterm=reverse ctermbg=NONE
highlight DiffDelete cterm=reverse ctermbg=NONE
highlight SpellBad cterm=reverse ctermbg=NONE
highlight SpellCap cterm=reverse ctermbg=NONE

" general settings
set autoread
set clipboard+=unnamed
set conceallevel=2
set cursorline
set expandtab
set gdefault
set hidden
set history=10000
set ignorecase
set mouse=a
set nobackup
set nofoldenable
set nojoinspaces
set noswapfile
set nowritebackup
set number
set shiftwidth=2
set smartcase
set softtabstop=2
set tabstop=2
set undodir=~/.vim/undo
set undofile
set wildignorecase

set viminfo='10000,n$HOME/.viminfo

" set shadafile=$HOME/.shadafile

" mappings
let mapleader = ' '

nnoremap <leader>= <C-w>=
nnoremap <leader>a :Grepper -tool rg -grepprg rg -H --no-heading --hidden --follow --glob "!.git/*" --vimgrep <cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>c :cclose<cr>
nnoremap <leader>f :NV<cr>
nnoremap <leader>h :set hls!<cr>
nnoremap <leader>j :bn<cr>
nnoremap <leader>k :bp<cr>
nnoremap <leader>n :set number! relativenumber!<cr>
nnoremap <leader>o :Obsession<cr>
nnoremap <leader>q :close<cr>
nnoremap <leader>s :split<cr>
nnoremap <leader>t :FZF<cr>
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>z :set spell! spelllang=en_us<cr>
nnoremap Y y$

" macros
let @l = 'i[](pa)^a'

" autocommands
autocmd BufWritePre *.js,*.ts,*.css,*.less,*.scss,*.json,*.graphql,*.md PrettierAsync
autocmd BufWritePre <buffer> :%s/\s\+$//e " strip trailing white space on save
autocmd FileType gitcommit set textwidth=72
autocmd BufRead,BufNewFile *.md setlocal textwidth=80

" functions
function! DirvishSetup()
  let text = getline('.')
  for item in split(&wildignore, ',')
    let xp = glob2regpat(item)
    exec 'silent keeppatterns g/.DS_Store/d'
  endfor
  exec 'sort ,^.*[\/],'
  let name = '^' . escape(text, '.*[]~\') . '[/*|@=]\=\%($\|\s\+\)'
  call search(name)
endfunction
