" ========== NetRW ==============================

let g:netrw_list_hide= '.*\.sw[a-p]$,.*\.py[cod]$,^__pycache__\/$'


" ========== Vim Airline =========================

" https://github.com/vim-airline/vim-airline/wiki/FAQ#vim-airline-doesnt-appear-until-i-create-a-new-split
set laststatus=2


" ========== CtrlP =========================

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]((\.(git|hg|svn))|(node_modules|bower_components))$',
  \ 'file': '\v\.(py[co]|swp|swo|exe|so|dll)$',
  \ }
let g:ctrlp_working_path_mode = 'rw'


" ========== Vim-JSX =======================

let g:jsx_ext_required = 0 " Allow JSX in normal JS files


" ========== Vim-Javascript ================

let g:javascript_plugin_jsdoc = 1


" ========== Syntastic ======================

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

" find and load nested configuration files
function! FindConfig(prefix, what, where)
    let cfg = findfile(a:what, escape(a:where, ' ') . ';')
    return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endfunction

let g:syntastic_python_checkers = ['flake8', 'py3kwarn']
let b:syntastic_python_pylint_args =
    \ get(g:, 'syntastic_python_pylint_args', '') .
    \ FindConfig('-c', '.pylintrc', expand('<afile>:p:h', 1))

let g:jsx_ext_required = 0

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
let b:syntastic_javascript_jscs_args =
    \ get(g:, 'syntastic_javascript_jscs_args', '') .
    \ FindConfig('-c', '.jscsrc', expand('<afile>:p:h', 1))

let b:syntastic_javascript_eslint_args =
    \ get(g:, 'syntastic_javascript_eslint_args', '') .
    \ FindConfig('-c', '.eslintrc*', expand('<afile>:p:h', 1))

autocmd FileType go let g:syntastic_aggregate_errors = 1
autocmd FileType go let g:syntastic_go_checkers = ["go", "govet", "golint"]

let g:syntastic_scala_checkers = ['fsc', 'scalastyle']


" ========== Vim Local vimrc ==================
let g:local_vimrc = {'names':['.local.vimrc'],'hash_fun':'LVRHashOfFile'}
