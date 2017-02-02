let python_highlight_all=1

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

let g:netrw_list_hide= '.*\.pyc$'

" Pylint settings with the Django plugin
let g:syntastic_python_pylint_args = "--load-plugins=pylint_django --disable=C0111"
