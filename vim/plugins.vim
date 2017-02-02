" ========== CtrlP =========================

" Ignore files and folders.
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|Trash)$',
  \ 'file': '\v(tags|\.(exe|so|dll|wav|mp3|mo|DS_Store|svn|png|jpe?g|jpg\.mno|gif|elc|rbc|pyc|swp|psd|ai|pdf|mov|aep|dmg|tar|zip|gz|shx|shp|wmf||bmp|ico|avi|docx?|xlsx?|pptx?|upart|ipa))$',
  \ 'link': '\v\.__INCLUDE_VERSION__$',
  \}


" ========== Vim-JSX =======================

let g:jsx_ext_required = 0 " Allow JSX in normal JS files


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

" Use the virtualenv pylint (if available)
" let g:syntastic_python_pylint_exec = '$(which pylint)'  

let g:syntastic_javascript_checkers = ['jscs', 'eslint']
