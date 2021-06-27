""""""""""""""""""""""""""""""""""""""
" auto download plug
"""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"""""""""""""""""""""""""""""""""""""""
" plug calls
"""""""""""""""""""""""""""""""""""""""
call plug#begin()
    " actually useful
    Plug 'tpope/vim-commentary'         " gcc Vgc
    Plug 'tpope/vim-surround'           " cs\"' 
    Plug 'tpope/vim-fugitive'           " !Git integration
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocomplete, linting
    Plug 'junegunn/fzf.vim'             " fzf plays nice with vim
    " rice
    Plug 'Yggdroot/indentLine'          " display indents :IndentLineToggle
    Plug 'skovati/skovati.vim'          " colorscheme
    Plug 'preservim/nerdtree'           " file tree
    Plug 'preservim/tagbar'             " tmp ctags display
    Plug 'mbbill/undotree'              " undo tree visualization
    Plug 'morhetz/gruvbox'              " gruvbox
    Plug 'junegunn/goyo.vim'            " distraction free writing
    Plug 'itchyny/lightline.vim'        " statusline
    Plug 'tpope/vim-markdown'           " markdown highlighing & folding
    " plugins that I'm reconsidering
    Plug 'vimwiki/vimwiki'              " note-taking, wiki
call plug#end()

"""""""""""""""""""""""""""""""""""""""
" set config
"""""""""""""""""""""""""""""""""""""""
" things that should be default
filetype plugin on
syntax on
set encoding=utf-8          " default in neovim
set backspace=indent,eol,start
set ttyfast                 " default in neovim
set autoread                " reloads current buffer if change detected
set autoindent              " indents based on previous line
set smartindent             " indents after { and others
set incsearch               " search as characters are entered

" comfy 4 space tabs        
set tabstop=4               
set shiftwidth=4
set softtabstop=4           " backspace will remove tabs instead of space
set expandtab               " expands tabs to spaces

" swap files annoy me more than help
set noswapfile
set nobackup

" syntax folding
" zc, zo, zr, zR
set foldmethod=syntax
set foldnestmax=10
set nofoldenable

" spell check
set spelllang=en_us
set complete+=kspell

" for custom statusline
set laststatus=2            " Always display the status line
set showmode!               " hide current mode

" persistent undo
set undodir=~/.vim/undodir
set undofile                

" misc
set history=10000           " large histroy
set complete-=i             " 
" set mouse=a                 " enable mouse
set wildmenu                " command line completion
set number relativenumber   " shows current & relative line numbers
set clipboard=unnamedplus   " default to system clipboard
set ignorecase              " case insensitive search
set smartcase               " case sensitive when uppercase
set showmatch               " highlight matching brackets
set shortmess+=F
set path+=**                " used for fuzzy file finding
set hlsearch                " highlight / matches

"""""""""""""""""""""""""""""""""""""""
" config for netrw browser
"""""""""""""""""""""""""""""""""""""""
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=3  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_winsize = 20    " limit split size
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide hidden files, toggle with gh

"""""""""""""""""""""""""""""""""""""""
" language specific formatting
"""""""""""""""""""""""""""""""""""""""
autocmd FileType systemverilog setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType markdown call SetProseOpts()
autocmd FileType text call SetProseOpts()
autocmd FileType help wincmd L " open help in vsplit

set omnifunc=syntaxcomplete#Complete

function SetProseOpts() 
    setlocal spell
    setlocal linebreak
    noremap <silent> k gk
    noremap <silent> j gj
    noremap <silent> 0 g0
    noremap <silent> $ g$
endfunction

"""""""""""""""""""""""""""""""""""""""
" colors
"""""""""""""""""""""""""""""""""""""""

colorscheme skovati " https://github.com/skovati/skovati.vim

set cursorline
set background=dark
set t_Co=256

if (has("termguicolors"))
  " set termguicolors
endif

"""""""""""""""""""""""""""""""""""""""
" keybinds
"""""""""""""""""""""""""""""""""""""""
" make leader key space
let mapleader=" " 
" map wq to esc
inoremap wq <Esc>
vnoremap wq <Esc>

" fix sticky shift
cnoremap W w
cnoremap Wq wq
cnoremap WQ wq
cnoremap wQ wq
cnoremap Q q

" show syntax highlighting group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" disable arrow keys to git gud
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" autoclose stuff
inoremap {<CR> {<CR>}<ESC>O

" Split Navigation shortcuts
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Goyo
noremap <leader>g :Goyo<CR>

" NerdTree
nnoremap <leader>n :NERDTreeToggle<CR>

" fzf
nnoremap <leader>f :Files<CR>

" tagbar
nnoremap <leader>t :TagbarToggle<CR>

" undotree
nnoremap <leader>u :UndotreeToggle<CR>

" toggle spellcheck quickly
nnoremap <leader>s :setlocal spell!<CR>

nnoremap <leader>c :call ToggleConcealLevel()<CR>

function ToggleConcealLevel()
    if &conceallevel == 2
        setlocal conceallevel=0
    else
        setlocal conceallevel=2
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""
" neovim/vim specific
"""""""""""""""""""""""""""""""""""""""

if has("nvim") 
    set guicursor=          " fixes alacritty changing cursor
"   set ttymouse=sgr
"   let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
endif

if !has("nvim") 
set encoding=utf-8          " unicode
set ttyfast                 " fix slugish scrolling
endif

"""""""""""""""""""""""""""""""""""""""
" plugin specific
"""""""""""""""""""""""""""""""""""""""
" nerdtree
" auto close vim if just nerdtree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeStatusline = '%#NonText#'     " hide statusline in nerdtree
let NERDTreeMinimalUI = 1                   " hide ? help

" tarbag
let g:tagbar_compact = 1

" fzf
let g:fzf_layout = { 'down': '~30%' }       " open fzf below

" vimwiki
" make it use markdown syntax
let g:vimwiki_list = [{'path': '/tmp/wiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
" and not treat every markdown as vimwiki
let g:vimwiki_global_ext = 0

" makes markdown linkes like [text](text.md) instead of [text](text)
let g:vimwiki_markdown_link_ext = 1

" coc
let g:coc_global_extensions = ['coc-pyright', 'coc-go', 'coc-json', 'coc-yaml']

" md
let g:markdown_folding = 1

"""""""""""""""""""""""""""""""""""""""
" coc recommended config
"""""""""""""""""""""""""""""""""""""""

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use D to show documentation in preview window.
nnoremap <leader>d :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>l  <Plug>(coc-format-selected)
nmap <leader>l  <Plug>(coc-format-selected)

"""""""""""""""""""""""""""""""""""""""
" statusline
"""""""""""""""""""""""""""""""""""""""

let g:lightline = {
\   'colorscheme': '16color',
\   'active': {
\     'left': [ [ 'mode', 'paste' ],
\               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
\     'right': [ [ 'lineinfo' ],
\              [ 'percent' ],
\              [ 'fileencoding', 'filetype' ] ]
\   },
\   'component_function': {
\     'gitbranch': 'FugitiveHead'
\   },
\   'tabline': {
\     'left': [ [ 'tabs' ] ]
\   }
\ }
