filetype on
set wildmenu
syntax on
set mouse=a 
colorscheme wal
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

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'sainnhe/forest-night'
call plug#end()

map <C-n> :NERDTreeToggle<CR>
