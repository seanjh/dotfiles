" ========== Vim Airline =========================

" https://github.com/vim-airline/vim-airline/wiki/FAQ#vim-airline-doesnt-appear-until-i-create-a-new-split
set laststatus=2


" ========== CtrlP =========================

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(pyc|swp|swo|exe|so|dll)$',
  \ }


" ========== Vim-JSX =======================

let g:jsx_ext_required = 0 " Allow JSX in normal JS files



" ========== Vim-Javascript ================

let g:javascript_plugin_jsdoc = 1


" ========== Syntastic ======================

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

let g:syntastic_python_checkers = ['flake8', 'pylint']
let g:syntastic_python_pylint_args = "--load-plugins=pylint_django --disable=C0111"

let g:syntastic_javascript_checkers = ['jscs', 'eslint']

let b:syntastic_javascript_jscs_args =
    \ get(g:, 'syntastic_javascript_jscs_args', '') .
    \ FindConfig('-c', '.jscsrc', expand('<afile>:p:h', 1))
let b:syntastic_javascript_eslint_args =
    \ get(g:, 'syntastic_javascript_eslint_args', '') .
    \ FindConfig('-c', '.eslintrc.json', expand('<afile>:p:h', 1))
let b:syntastic_python_pylint_args =
    \ get(g:, 'syntastic_python_pylint_args', '') .
    \ FindConfig('-c', '.pylintrc', expand('<afile>:p:h', 1))
