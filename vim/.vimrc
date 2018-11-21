" plugins
" -------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'Alok/notational-fzf-vim'
Plug 'LeonB/vim-nginx', { 'for': 'nginx' }
Plug 'Raimondi/delimitMate'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
Plug 'justinmk/vim-dirvish'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-grepper'
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx', 'jsx']}
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'reedes/vim-pencil'
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'w0rp/ale'

" NEVER SET UP CORRECTLY
" Plug 'chrisbra/csv.vim', {'for': 'csv'}
" Plug 'lifepillar/pgsql.vim'
" Plug 'lifepillar/vim-mucomplete'

call plug#end()

" notational-fzf
let g:nv_search_paths = ['~/Documents/notes']
let g:nv_ignore_pattern = ['.git']
let g:nv_use_short_pathnames = 1

" deoplete
let g:deoplete#enable_at_startup = 1

let g:dirvish_mode = 'call DirvishSetup()'

" jsx
let g:jsx_ext_required = 0

let g:user_emmet_install_global = 0
let g:user_emmet_settings = {'javascript.jsx' : {'extends' : 'jsx'}}

let g:goyo_width = 71

let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript', 'html', 'css', 'python', 'bash=sh', 'rust']
let g:markdown_syntax_conceal = 1

" prettier
" let g:prettier#autoformat = 0
let g:prettier#quickfix_enabled = 0
let g:prettier#config#semi = 'false'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'babylon'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#single_quote = 'true'

" pencil
let g:pencil#wrapModeDefault = 'soft'

" TODO get this working
" let g:ale_linters = {
" \   'javascript': ['eslint', 'standard'],
" \}
" let g:ale_fixers = {}
" let g:ale_fixers['javascript'] = ['prettier']
" let g:ale_fix_on_save = 1
" let g:ale_javascript_prettier_options = '--single-quote --no-semi --arrow-parens avoid --trailing-comma none'

" TODO https://github.com/lifepillar/vim-mucomplete
" set completeopt-=preview
" set completeopt+=menuone,noinsert,noselect
" let g:mucomplete#enable_auto_at_startup = 1
" filetype plugin on
" set omnifunc=syntaxcomplete#Complete

" options
" -------------------------------------
set t_Co=256
set nocompatible
set clipboard+=unnamed
set cursorline
set expandtab
set filetype=off
set foldenable
set foldlevel=99      " Don't autofold anything
set foldlevelstart=99 " Don't autofold anything
set foldmethod=syntax
set foldtext=FoldText()
set gdefault
set hidden
set ignorecase
set indentexpr=off
set lazyredraw
set list                   " show non-printing characters sometimes
set listchars=             " clear defaults
set listchars+=tab:›\ "    " show a small chevron for a tab
set listchars+=trail:·     " show a small interpunct for trailing whitespace
set listchars+=nbsp:␣      " show a small open box for non-breaking spaces
set listchars+=extends:›   " show a small chevron for text to the right
set listchars+=precedes:‹  " show a small chevron for text to the left
set listchars+=eol:\ "     " show nothing at the end of a line
set matchtime=3
set mouse=a
set nobackup
set noerrorbells
set nohlsearch
set nojoinspaces
" set noshowcmd
set showcmd
set noshowmode
set nospell
set noswapfile
set nowrap
set nowritebackup
set number
set relativenumber
set scrolloff=3
set secure
set shiftwidth=2
set shortmess+=IW
set showmatch
set smartcase
set softtabstop=2
set splitbelow
set splitright
set statusline=%F%m%r%h%w\ [%l,%c]\ [%L,%p%%]\ %{fugitive#statusline()}
set tabstop=2
set termguicolors
set textwidth=72
set title
set undodir=~/.vim/undo
set undofile
set wildchar=<tab>
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*,*/.DS_Store
set wildignore+=*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/coverage/*,*/yarn.lock
set wildignorecase
set wildmode=longest,list,full

" TODO testing this out
set wrap
set nolinebreak

" TODO necessary?
let base16colorspace=256
colorscheme base16-gruvbox-dark-pale

syntax enable
syntax sync minlines=256
set synmaxcol=300  " stop syntax highlighting this many columns out

" cabbr <expr> %% fnameescape(expand('%:p:h'))

" maps
" -------------------------------------
let mapleader=' '

nnoremap <leader>w :w<cr>

" toggle highlight search
nnoremap <leader>h :set hlsearch!<cr>

" fzf
nnoremap <leader>t :FZF<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :NV<cr>

" folds
nnoremap <leader><space> za
nnoremap <leader>r zR
nnoremap <leader>m zM

" handle splits
nnoremap <silent> <leader>s :split<cr>
nnoremap <silent> <leader>v :vsplit<cr>
nnoremap <silent> <leader>q :close<cr>
nnoremap <leader>= <C-w>=

nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>

nnoremap <silent> <leader>g :Goyo<cr>
nnoremap <silent> <leader>l :Limelight!!<cr>

nnoremap <leader>d :!vmd % &<cr>

" save file as sudo http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %

" text search current working directory
nnoremap <leader>a :Grepper
 \ -tool rg
 \ -grepprg rg -H --no-heading --hidden --follow --glob "!.git/*" --vimgrep
 \ <cr>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" map ctrl-j to split a line
nnoremap <nl> i <cr><esc>

" map . in visual mode
vnoremap . :norm.<cr>

" yank to end of line
noremap Y y$

" commands
" -------------------------------------
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

command! TODO :Grepper
      \ -noprompt
      \ -tool git
      \ -grepprg git grep -nIi '\(TODO\|FIXME\)'

" autocmds
" -------------------------------------
function! DirvishSetup()
  let text = getline('.')
  for item in split(&wildignore, ',')
    let xp = glob2regpat(item)
    exec 'silent keeppatterns g/.DS_Store/d'
  endfor
  exec 'sort ,^.*[\/],'
  let name = '^' . escape(text, '.*[]~\') . '[/*|@=]\=\%($\|\s\+\)'
  call search(name)
endfunc

function! MarkdownEnter()
  set filetype=markdown
  setlocal spell
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

autocmd BufWritePre <buffer> :%s/\s\+$//e   " strip trailing white space on save
" autocmd FileType help wincmd L              " open help in vertical split
autocmd FileType html,css,javascript.jsx EmmetInstall
autocmd FileType html setlocal textwidth=0
autocmd FileType gitcommit set textwidth=72

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

autocmd BufWritePre,BufNewFile,BufReadPost *.md :call MarkdownEnter()
autocmd BufWritePre,BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufReadPost *.json set nofoldenable

" TODO prettier markdown formatting is borked, dunno why
" auto format using prettier for supported filetypes
" autocmd BufWritePre *.js,*.ts,*.css,*.less,*.scss,*.json,*.graphql,*.md PrettierAsync
autocmd BufWritePre *.js,*.ts,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync
