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
Plug 'tpope/vim-commentary' "gcc Vgc
Plug 'Yggdroot/indentLine' " display indents :IndentLineToggle
Plug 'tpope/vim-surround'
Plug 'skovati/skovati.vim'
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
set ttymouse=sgr
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
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view

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

set background=dark
set t_Co=256

"""""""""""""""""""""""""""""""""""""""
" keybinds
"""""""""""""""""""""""""""""""""""""""
inoremap wq <Esc>
cmap W w
cmap Wq wq
cmap WQ wq
cmap wQ wq
cmap Q q

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
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O

"""""""""""""""""""""""""""""""""""""""
" statusline
"""""""""""""""""""""""""""""""""""""""
let g:currentmode={
    \ 'n'  : 'normal ',
    \ 'v'  : 'visual ',
    \ 'V'  : 'v line ',
    \ '' : 'v block ',
    \ 'i'  : 'insert ',
    \ 'R'  : 'r ',
    \ 'Rv' : 'v replace ',
    \ 'c'  : 'command ',
    \}

set statusline=
set statusline+=%1*\ %1*%{g:currentmode[mode()]}
set statusline+=%2*\ %f\ "
set statusline+=%6*\ %=
set statusline+=%3*\ %Y\ "
set statusline+=\%5*\ %v:%l\/%L
set statusline+=\ "
