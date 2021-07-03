"""""""""""""""""""""""""""""""""""""""
" skovati's vimrc
" this is a minimal subset of my neovim
" configuration that works with vanilla vim
" and uses no external plugins
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
" general set conf
"""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on

set smartindent             " indents after { and others

" comfy 4 space tabs        
set tabstop=4               " 4 spaces per tab
set shiftwidth=4            " amount to shift with >>
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
set complete+=kspell        " add spelling to completion

set number relativenumber   " shows current & relative line numbers
set clipboard=unnamedplus   " default to system clipboard
set ignorecase              " case insensitive search
set smartcase               " case sensitive when uppercase
set showmatch               " highlight matching brackets
set shortmess+=F            " hide 
set path+=**                " used for fuzzy file finding

set cursorline

"""""""""""""""""""""""""""""""""""""""
" vim specific 
"""""""""""""""""""""""""""""""""""""""
if !has("nvim") 
    set encoding=utf-8
    set backspace=indent,eol,start
    set ttyfast
    set incsearch               " search as characters are entered
    set autoread                " reloads current buffer if change detected
    set autoindent              " indents based on previous line
    set hlsearch                " highlight / matches
    set complete-=i             " remove sourced files from complete
    set history=10000           " large histroy
    set wildmenu                " command line completion
    " rice
    set background=dark
    colorscheme slate
    " persistent undo
    set undodir=~/.vim/undodir  
    set undofile
    " config for netrw browser
    let g:netrw_banner=0        " disable annoying banner
    let g:netrw_browse_split=3  " open in prior window
    let g:netrw_altv=1          " open splits to the right
    let g:netrw_liststyle=3     " tree view
    let g:netrw_winsize = 20    " limit split size
    let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide hidden files, toggle with gh
endif

"""""""""""""""""""""""""""""""""""""""
" language specific 
"""""""""""""""""""""""""""""""""""""""
set omnifunc=syntaxcomplete#Complete

autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab

"""""""""""""""""""""""""""""""""""""""
" keybinds
"""""""""""""""""""""""""""""""""""""""

" make leader key space
let mapleader=" " 
" map wq to esc
inoremap wq <Esc>
vnoremap wq <Esc>

" fix sticky shift
cmap W w
cmap Wq wq
cmap WQ wq
cmap wQ wq
cmap Q q

" autoclose stuff
inoremap {<CR> {<CR>}<ESC>O

" Split Navigation shortcuts
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
