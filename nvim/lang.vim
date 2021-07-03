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

function SetProseOpts() 
    setlocal spell
    setlocal linebreak
    noremap <silent> k gk
    noremap <silent> j gj
    noremap <silent> 0 g0
    noremap <silent> $ g$
endfunction
