let python_highlight_all=1

highlight badwhitespace ctermbg=red guibg=darkred
au bufread,bufnewfile *.py,*.pyw,*.c,*.h match badwhitespace /\s\+$/

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

let g:netrw_list_hide= '.*\.pyc$'
