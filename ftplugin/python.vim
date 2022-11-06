" python mode configuration
" shiftround - round the indent to a multiple of shiftwidth
autocmd BufNewFile,BufRead *.py
    \ set tabstop=4
    \ softtabstop=6
    \ shiftwidth=4
    \ shiftround                         
    \ textwidth=79
    \ fileformat=unix


" i'm doing everything in python3 these days.
let g:pymode_python = 'python3'
