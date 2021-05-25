"""""""""""""""""""""""""""""""""""""""
" auto download plug
"""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"""""""""""""""""""""""""""""""""""""""
" plugin calls
"""""""""""""""""""""""""""""""""""""""
call plug#begin()
    Plug 'tpope/vim-commentary'         " gcc Vgc
    Plug 'Yggdroot/indentLine'          " display indents :IndentLineToggle
    Plug 'tpope/vim-surround'           " ysiw'
    Plug 'skovati/skovati.vim'          " colorscheme
    Plug 'preservim/nerdtree'           " file tree
    Plug 'preservim/tagbar'             " temp ctags display
    Plug 'neoclide/coc.nvim', {'branch': 'release'} "auto complete + linting
    Plug 'junegunn/goyo.vim'            " distraction free writing
    Plug 'junegunn/fzf.vim'
    Plug 'sheerun/vim-polyglot'         " better syntax highlighting
    Plug 'vimwiki/vimwiki'
call plug#end()

"""""""""""""""""""""""""""""""""""""""
" set config
"""""""""""""""""""""""""""""""""""""""
filetype on
set wildmenu
syntax on
set encoding=utf-8
set mouse=a 
set noerrorbells   " why is this a default
set tabstop=4
set shiftwidth=4
set softtabstop=4  " backspace will remove tabs instead of space
set expandtab
set number relativenumber
set backspace=indent,eol,start
set noswapfile 
set nobackup
set clipboard=unnamedplus
set ttyfast
set incsearch       " search as characters are entered
set ignorecase      " case insensitive search
set smartcase       " case sensitive when uppercase
set laststatus=2    " Always display the status line
set showmode!       " hide current mode
set showmatch       " highlight matching brackets
set autoindent
set smartindent
set shortmess+=F
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set spelllang=en_us
set path+=**        " used for fuzzy file finding
set undodir=~/.vim/undodir
set undofile
set hlsearch        " highlight / matches

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
"language specific formatting
"""""""""""""""""""""""""""""""""""""""
autocmd FileType systemverilog setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType markdown call SetProseOpts()
autocmd FileType text call SetProseOpts()

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
colorscheme skovati

set cursorline
set background=dark
set t_Co=256

"""""""""""""""""""""""""""""""""""""""
" keybinds
"""""""""""""""""""""""""""""""""""""""
let mapleader=" "
inoremap wq <Esc>
cmap W w
cmap Wq wq
cmap WQ wq
cmap wQ wq
cmap Q q

" tagbar
nmap <leader>t :TagbarToggle<CR>
let g:tagbar_compact = 1

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
nnoremap <leader>. :NERDTreeFind<CR>

" fzf
nnoremap <leader>f :Files<CR>

"""""""""""""""""""""""""""""""""""""""
" neovim specific
"""""""""""""""""""""""""""""""""""""""
set guicursor=
" if !has(nvim) {
"     set ttymouse=sgr
" }

"""""""""""""""""""""""""""""""""""""""
" plugin specific
"""""""""""""""""""""""""""""""""""""""
" nerdtree
" auto close vim if just nerdtree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeStatusline = '%#NonText#'     " hide statusline in nerdtree
let NERDTreeMinimalUI = 1                   " hide ? help
let NERDTreeDirArrows = 1                   " pretty arrows

" fzf
let g:fzf_layout = { 'down': '~40%' }

"""""""""""""""""""""""""""""""""""""""
" statusline
"""""""""""""""""""""""""""""""""""""""
" this array is called with mode() to get a formatted mode title
let g:currentmode={
     \ 'n'  : 'normal ',
     \ 'v'  : 'visual ',
     \ 'V'  : 'v line ',
     \ '' : 'v block ',
     \ 'i'  : 'insert ',
     \ 'R'  : 'r ',
     \ 'Rv' : 'v replace ',
     \ 'c'  : 'command ',
     \ 't'  : 'fzf ',
     \}
 
set statusline=                                         " clear statusline
set statusline+=%2*\ %{g:currentmode[mode()]}           " get formatted mode from array above
set statusline+=%3*\ %t\ "                              " print local current file path
set statusline+=%8*\ %M                                 " print + if current file has changes made
set statusline+=%8*\ %R                                 " print RO if current file is read only
set statusline+=%8*\ %=                                 " spacing between left and right
set statusline+=%1*\ %y\ "                              " show filetype
set statusline+=\%4*\ %l\/%L                            " show current line number vs total number
set statusline+=\:"                                     " colon between line and column
set statusline+=\%4*\%v                                 " column number
set statusline+=\ %8*"                                  " final space for formattin
