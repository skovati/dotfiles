if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary' "gcc Vgc
Plug 'Yggdroot/indentLine' " display indents :IndentLineToggle
    
call plug#end()


set termguicolors
filetype on
set wildmenu
syntax on
set mouse=a 
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
vmap <C-C> "+yi
vmap <C-V> c<ESC>"+p 
if $SSH_CONNECTION
    colorscheme slate
endif
set tabstop=4
set shiftwidth=4
set expandtab
set t_Co=256
set number
hi Normal ctermbg=none
hi EndOfBuffer ctermfg=none ctermbg=none
set backspace=indent,eol,start
set noswapfile nobackup
inoremap wq <Esc>
nnoremap <C-w> :w
set clipboard=unnamedplus
set ttymouse=sgr
set ttyfast

map <C-n> :NERDTreeToggle<CR>
