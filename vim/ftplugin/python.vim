let python_highlight_all=1

let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace', 'isort', 'black']

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=120
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
setlocal colorcolumn=80
