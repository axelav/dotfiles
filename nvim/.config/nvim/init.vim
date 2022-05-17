" plugins
call plug#begin(stdpath('data') . '/plugged')

" Plug 'arcticicestudio/nord-vim'
Plug 'dag/vim-fish'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'justinmk/vim-dirvish'
Plug 'jxnblk/vim-mdx-js', {'for': ['mdx']}
Plug 'leafgarland/typescript-vim', {'for': ['typescript', 'typescriptreact', 'tsx']}
Plug 'maxmellon/vim-jsx-pretty', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx', 'jsx']}
" Plug 'pantharshit00/vim-prisma'
Plug 'plasticboy/vim-markdown'
Plug 'tomlion/vim-solidity'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-scripts/paredit.vim'

Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

call plug#end()

" plugin settings
let g:dirvish_mode = 'call DirvishSetup()'
let g:goyo_height = '100%'
let g:goyo_width = 81
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_strikethrough = 1

" colors
syntax enable
" colorscheme nord

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
set undofile
set wildignorecase

" mappings
let mapleader = ' '

nnoremap <leader>= <C-w>=
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>c :ToggleQuickFix<CR>
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
nnoremap <leader>t :GFiles<cr>
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>z :set spell! spelllang=en_us<cr>

nnoremap Y y$

nnoremap <C-W><C-R> :Cargo run<cr>
nnoremap <C-W><C-F> :RustFmt<cr>


" autocommands
autocmd FileType gitcommit set textwidth=72
" autocmd BufRead,BufNewFile *.md setlocal textwidth=80
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

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

" https://github.com/tpope/vim-unimpaired/issues/97#issuecomment-807639978
function! ToggleQuickFix()
  if getqflist({'winid' : 0}).winid
    cclose
  else
    copen
  endif
endfunction

command! -nargs=0 -bar ToggleQuickFix call ToggleQuickFix()

" https://github.com/mhinz/vim-grepper/issues/244#issuecomment-892227766
set grepprg=rg\ --vimgrep\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m

nnoremap <Leader>a :silent grep<Space>
nnoremap gs :silent grep <C-r><C-w><CR>:copen<CR>
xnoremap gs "sy:silent grep <C-r>s<CR>:copen<CR>

" Rust
" https://github.com/rust-lang/rust.vim
filetype plugin indent on

let g:racer_cmd = "racer"
let g:racer_experimental_completer = 1
" let g:racer_insert_paren = 1

augroup Racer
  autocmd!
  autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
  " autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
  autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
  " autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
  autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
  " autocmd FileType rust nmap <buffer> <leader>gD <Plug>(rust-doc-tab)
augroup END
