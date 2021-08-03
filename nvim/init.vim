" skovati's neovim config
" https://github.com/skovati/dotfiles

" source other VimL files
" TODO find other way to source
source /home/skovati/.config/nvim/plugs.vim
source /home/skovati/.config/nvim/sets.vim
source /home/skovati/.config/nvim/maps.vim
source /home/skovati/.config/nvim/colors.vim
source /home/skovati/.config/nvim/lang.vim

" source lua files
lua require("init")
