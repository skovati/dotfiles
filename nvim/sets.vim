" misc
set smartindent
set tabstop=4				" 4 space tabs
set softtabstop=4			" backspace removes all spaces
set shiftwidth=4            " >> shifts by 4
set expandtab				" insert tabs as spaces
set number relativenumber   " line nums
set clipboard=unnamedplus   " share + register with system
set ignorecase              " ignore case in searches
set smartcase               " unless capital query
set showmatch               " highlight matching brackets
set path+=**                " enable fuzzy :find ing
set shortmess+=F
set guicursor=              " fixes alacritty changing cursor

" better backups (~/.local/share/nvim/undo)
set noswapfile              " disable swapfiles
set nobackup                " and auto backps, to instead use
set undofile                " enable auto save of undos

" syntax folding: zc, zo, zr, zR
set foldmethod=syntax
set foldnestmax=10
set nofoldenable

" spell check
set spelllang=en_us
set complete+=kspell

" for custom statusline
set laststatus=2            " Always display the status line
set showmode!               " hide current mode
