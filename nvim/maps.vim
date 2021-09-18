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

" LaTeX
noremap <leader>be i\begin{equation}<CR>\end{equation}<ESC>O
noremap <leader>bm i\(\)<ESC>h

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
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>

" tagbar
nmap <leader>t :TagbarToggle<CR>

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
