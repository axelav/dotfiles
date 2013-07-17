" Make Vim more useful
set nocompatible

" Set syntax highlighting
set background=dark
syntax enable

" Enabled later, after Vundle
filetype off

" Change mapleader
let mapleader=","

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Set a bunch of stuff
set autoindent " Copy indent from last line when starting new line.
set backspace=indent,eol,start " Allow backspace in insert mode
set binary
set clipboard=unnamed " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set cursorline " Highlight current line
set encoding=utf-8 nobomb " Use UTF-8 without BOM
set esckeys " Allow cursor keys in insert mode
set expandtab " Expand tabs to spaces
set exrc " Enable per-directory .vimrc files and disable unsafe commands in them
set foldcolumn=4 " Column to show folds
set foldenable
set foldlevel=2
set foldmethod=syntax " Markers are used to specify folds.
set foldminlines=0 " Allow folding single lines
set foldnestmax=3 " Set max fold nesting level    "
set formatoptions=
set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words        "
set gdefault " Add the g flag to search/replace by default
set hidden " When a buffer is brought to foreground, remember undo history & marks
set history=1000 " Increase history from 20 to 1000
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set incsearch " Highlight dynamically as pattern is typed
set laststatus=2 " Always show status line
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_ " Show “invisible” characters
set list
set modeline " Respect modeline in files
set modelines=4
set mouse=a " Enable mouse in all modes
set noerrorbells " Disable error bells
set nostartofline " Don’t reset cursor to start of line when moving around.
set number " Enable line numbers
set ruler " Show the cursor position
set scrolloff=10 " Start scrolling ten lines before the horizontal window border
set secure
set shiftwidth=4 " The number of spaces to indent
set shortmess=atI " Don’t show the intro message when starting Vim
set showcmd " Show the (partial) command as it’s being typed
set showmode " Show the current mode
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.
set tabstop=4 " Make tabs as wide as four spaces
set title " Show the filename in the window titlebar
set ttyfast " Optimize for fast terminal connections
set undofile " Persistent undo
set wildchar=<TAB> " Character for CLI expansion (TAB-completion).
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/smarty/*,*/vendor/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/* "
set wildmenu " Enhance command-line completion


" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost,BufNewFile * set relativenumber
endif

" JSON
au BufRead,BufNewFile *.json set ft=json syntax=javascript

" Jade
au BufRead,BufNewFile *.jade set ft=jade syntax=jade

" Vundle config
" https://github.com/gmarik/vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle "gmarik/vundle"

" My Bundles
Bundle "pangloss/vim-javascript"
Bundle "vim-scripts/pathogen.vim"
Bundle "walm/jshint.vim"
Bundle "Townk/vim-autoclose"

filetype plugin indent on

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif
