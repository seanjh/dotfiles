let python_highlight_all=1

highlight badwhitespace ctermbg=red guibg=darkred
au bufread,bufnewfile *.py,*.pyw,*.c,*.h match badwhitespace /\s\+$/

setlocal colorcolumn=99

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=120 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    "\ set colorcolumn=100 |

let g:netrw_list_hide= '.*\.py[co]$'
