highlight BadWhitespace ctermbg=red guibg=darkred

let b:ale_linters = ['eslint']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace', 'eslint', 'prettier']
let g:ale_fix_on_save = 1

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix

au BufRead,BufNewFile *.js,*.jsx,*.json match BadWhitespace /\s\+$/

