" ========== Syntastic =====================

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2               "Close automatically, open manually
let g:syntastic_check_on_open = 0               "Display errors on open
let g:syntastic_check_on_wq = 0                 "Display errors on save
let g:syntastic_aggregate_errors = 1

" find and load nested configuration files
function! FindConfig(prefix, what, where)
    let cfg = findfile(a:what, escape(a:where, ' ') . ';')
    return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endfunction

let g:syntastic_javascript_checkers = ['jscs', 'eslint']
let g:syntastic_python_checkers = ["flake8"]
