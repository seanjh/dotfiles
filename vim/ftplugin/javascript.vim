highlight BadWhitespace ctermbg=red guibg=darkred

au BufRead,BufNewFile *.js,*.jsx,*.json
    \ match BadWhitespace /\s\+$/ |
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
