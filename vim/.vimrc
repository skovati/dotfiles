" auto download plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" set config
filetype on
set wildmenu
syntax on
set mouse=a 
set tabstop=4
set shiftwidth=4
set softtabstop=4   " backspace will remove tabs instead of space
set expandtab
set number
set backspace=indent,eol,start
set noswapfile 
set nobackup
set clipboard=unnamedplus
set ttymouse=sgr
set ttyfast
set incsearch " search as characters are entered
set ignorecase  " case insensitive search
set smartcase   " case sensitive when uppercase
set laststatus=2    " Always display the status line
set showmode!   " hide current mode
set showmatch   " highlight matching brackets
set autoindent
set smartindent
set shortmess+=F

" colors
colorscheme wal
hi Normal ctermbg=none
hi EndOfBuffer ctermfg=none ctermbg=none
set background=dark
let base16colorspace=256
set t_Co=256

" keybinds
vmap <C-C> "+yi
vmap <C-V> c<ESC>"+p 
inoremap wq <Esc>
nnoremap <C-w> :w
map <C-n> :NERDTreeToggle<CR>
cmap W w
cmap Wq wq
cmap WQ wq
cmap wQ wq
cmap Q q

" statusline
hi User1 ctermfg=black ctermbg=green
hi User2 ctermfg=black ctermbg=blue
hi User3 ctermfg=black ctermbg=red
hi User4 ctermfg=black ctermbg=magenta
hi User5 ctermfg=black ctermbg=yellow
hi User6 ctermfg=none ctermbg=black

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
set statusline+=%4*\ %4*%{g:currentmode[mode()]}
set statusline+=%6*\ %f
set statusline+=\ %6*\ %{&modified?'[+]':''}
set statusline+=\ %=%6*
set statusline+=\ %5*\ %v:%l\/%L
set statusline+=\ "

" plugin calls
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary' "gcc Vgc
Plug 'Yggdroot/indentLine' " display indents :IndentLineToggle
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-surround'
call plug#end()
