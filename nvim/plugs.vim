""""""""""""""""""""""""""""""""""""""""
" autoload plug
""""""""""""""""""""""""""""""""""""""""
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""""""""""""""""""""""""""""""""""""""
" plug call
""""""""""""""""""""""""""""""""""""""""
call plug#begin()
    " actually useful
    Plug 'tpope/vim-commentary'         " gcc Vgc
    Plug 'tpope/vim-surround'           " cs\"' 
    Plug 'tpope/vim-fugitive'           " !Git integration
    " rice
    Plug 'Yggdroot/indentLine'          " display indents :IndentLineToggle
    Plug 'skovati/skovati.vim'          " colorscheme
    Plug 'preservim/nerdtree'           " file tree
    Plug 'preservim/tagbar'             " tmp ctags display
    Plug 'mbbill/undotree'              " undo tree visualization
    Plug 'morhetz/gruvbox'              " gruvbox
    Plug 'junegunn/goyo.vim'            " distraction free writing
    Plug 'itchyny/lightline.vim'        " statusline
    " plugins that I'm reconsidering
    Plug 'vimwiki/vimwiki'              " note-taking, wiki
    " neovim specific
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
call plug#end()

"""""""""""""""""""""""""""""""""""""""
" netrw
"""""""""""""""""""""""""""""""""""""""
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=3  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_winsize = 20    " limit split size
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide hidden files, toggle with gh

""""""""""""""""""""""""""""""""""""""""
" statusline
""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""
" other plugins
""""""""""""""""""""""""""""""""""""""""
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
