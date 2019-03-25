let b:ale_linters = ['swaglint', 'yamllint', 'cfn-lint']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']

au BufRead,BufNewFile *.yml,*.yaml
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
