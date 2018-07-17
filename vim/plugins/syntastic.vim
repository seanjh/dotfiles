set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1

let g:syntastic_mode_map = {
  \ "mode": "active",
  \ "active_filetypes": [],
  \ "passive_filetypes": ["scala"] }

" Find and load nested configuration files
function! FindConfig(prefix, what, where)
    let cfg = findfile(a:what, escape(a:where, ' ') . ';')
    return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endfunction


" Python

let g:syntastic_python_checkers = ['flake8', 'py3kwarn']

let b:syntastic_python_pylint_args =
    \ get(g:, 'syntastic_python_pylint_args', '') .
    \ FindConfig('-c', '.pylintrc', expand('<afile>:p:h', 1))


" JavaScript

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
let b:syntastic_javascript_jscs_args =
    \ get(g:, 'syntastic_javascript_jscs_args', '') .
    \ FindConfig('-c', '.jscsrc', expand('<afile>:p:h', 1))
let b:syntastic_javascript_eslint_args =
    \ get(g:, 'syntastic_javascript_eslint_args', '') .
    \ FindConfig('-c', '.eslintrc*', expand('<afile>:p:h', 1))


" Golang

autocmd FileType go let g:syntastic_aggregate_errors = 1
autocmd FileType go let g:syntastic_go_checkers = ["go", "govet", "golint"]
