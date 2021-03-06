setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

autocmd FileType go nmap <leader>d <plug>(go-doc)
autocmd FileType go nmap <leader>r <plug>(go-run)
autocmd FileType go nmap <leader>b <plug>(go-build)
autocmd FileType go nmap <leader>t <plug>(go-test)

let b:ale_linters = ['gobuild', 'gofmt', 'golint', 'gopls', 'govet']
let b:ale_fixers = ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace']
