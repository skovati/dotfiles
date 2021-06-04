"""""""""""""""""""""""""""""""""""""""
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
    Plug 'tpope/vim-commentary'         " gcc Vgc
    Plug 'Yggdroot/indentLine'          " display indents :IndentLineToggle
    Plug 'tpope/vim-surround'           " cs\"' 
    Plug 'skovati/skovati.vim'          " colorscheme
    Plug 'preservim/nerdtree'           " file tree
    Plug 'preservim/tagbar'             " tmp ctags display
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocomplete, linting
    Plug 'junegunn/goyo.vim'            " distraction free writing
    Plug 'junegunn/fzf.vim'             " fzf plays nice with vim
    Plug 'mbbill/undotree'              " undo tree visualization
    Plug 'chriskempson/base16-vim'      " colorscheme
    Plug 'morhetz/gruvbox'              " gruvbox

    " plugins that I'm reconsidering
    " Plug 'vimwiki/vimwiki'              " note-taking, wiki
call plug#end()

"""""""""""""""""""""""""""""""""""""""
" set config
"""""""""""""""""""""""""""""""""""""""
" things that should be default
filetype plugin on
syntax on
set encoding=utf-8          " defaualt on neovim
set noerrorbells            " why is this a default
set belloff=all
set backspace=indent,eol,start
set ttyfast
set autoread
set autoindent
set smartindent
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
set history=10000
set complete-=i
set mouse=a                 " enable mouse
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

" this is run when editing text or markdown
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

" Split Navigation shortcuts
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Goyo
noremap <leader>g :Goyo<CR>

" NerdTree
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" fzf
nnoremap <leader>f :Files<CR>

" tagbar
nmap <leader>t :TagbarToggle<CR>

" undotree
nnoremap <leader>u :UndotreeToggle<CR>

" toggle spellcheck quickly
nnoremap <leader>s :setlocal spell!<CR>

nnoremap <leader>c :setlocal conceallevel=0<CR>

" coc go to definition
nmap <silent> gd <Plug>(coc-definition)

"""""""""""""""""""""""""""""""""""""""
" neovim specific
"""""""""""""""""""""""""""""""""""""""

if has("nvim") 
    set guicursor=          " fixes alacritty changing cursor
"   set ttymouse=sgr
"   let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
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
let g:vimwiki_list = [{'path': '~/dev/git/vimwiki/', 'path_html': '~/dev/git/vimwiki/html/'}]

" coc
let g:coc_global_extensions = ['coc-pyright', 'coc-go', 'coc-json', 'coc-yaml']

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

"""""""""""""""""""""""""""""""""""""""
" coc recommended config
"""""""""""""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" indentLine
" let g:indentLine_setConceal = 0

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

" set custom statusline
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
