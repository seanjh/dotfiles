highlight BadWhitespace ctermbg=red guibg=darkred

let b:ale_completion_enabled = 1
let b:ale_completion_tsserver_autoimport = 1

let b:ale_linters = ['eslint', 'tsserver']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace', 'eslint', 'prettier']

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
