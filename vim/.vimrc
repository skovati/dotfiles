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
set expandtab
set number
set backspace=indent,eol,start
set noswapfile 
set nobackup
set clipboard=unnamedplus
set ttymouse=sgr
set ttyfast

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

" plugin calls
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary' "gcc Vgc
Plug 'Yggdroot/indentLine' " display indents :IndentLineToggle
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-surround'
call plug#end()
