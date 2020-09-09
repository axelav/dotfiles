" plugins
call plug#begin('~/.vim/plugged')

Plug 'Alok/notational-fzf-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'justinmk/vim-dirvish'
Plug 'jxnblk/vim-mdx-js', {'for': ['mdx']}
Plug 'maxmellon/vim-jsx-pretty', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'mhinz/vim-grepper'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'

call plug#end()

" plugin settings
let g:dirvish_mode = 'call DirvishSetup()'
let g:goyo_height = '100%'
let g:goyo_width = 81
let g:nv_ignore_pattern = ['.git']
let g:nv_search_paths = ['~/Documents/notes']
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_strikethrough = 1

" colors
syntax on
colorscheme nord

" general settings
set autoread
set clipboard+=unnamed
set cursorline
set expandtab
set gdefault
set hidden
set history=10000
set ignorecase
set mouse=a
set nobackup
set nofoldenable
set nohlsearch
set nojoinspaces
set noswapfile
set nowritebackup
set number
set shiftwidth=2
set smartcase
set softtabstop=2
set spellcapcheck=
set tabstop=2
set undodir=~/.vim/undo
set undofile
set wildignorecase

if !has('nvim')
  set viminfo+=~/.vim/viminfo
else
  set viminfo='10000,n~/.config/nvim/shada
endif

" mappings
let mapleader = ' '

nnoremap <leader>= <C-w>=
nnoremap <leader>a :Grepper -tool rg -grepprg rg -H --no-heading --hidden --follow --glob "!.git/*" --vimgrep <cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>c :cclose<cr>
nnoremap <leader>f :NV<cr>
nnoremap <leader>g :Goyo<cr>
nnoremap <leader>h :set hls!<cr>
nnoremap <leader>j :bn<cr>
nnoremap <leader>k :bp<cr>
nnoremap <leader>n :set number!<cr>
nnoremap <leader>o :Obsession<cr>
nnoremap <leader>q :close<cr>
nnoremap <leader>r :set relativenumber!<cr>
nnoremap <leader>s :split<cr>
nnoremap <leader>t :FZF<cr>
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>z :set spell! spelllang=en_us<cr>

nnoremap <C-W><C-F> <C-W>vgf
nnoremap Y y$

" autocommands
autocmd FileType gitcommit set textwidth=72
" autocmd BufRead,BufNewFile *.md setlocal textwidth=80

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
