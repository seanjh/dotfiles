" Disable quote concealing in JSON files
let g:vim_json_conceal=0

let b:ale_linters = ['jq', 'jsonlint', 'vscodejson']
let b:ale_fixers = ['jq', 'remove_trailing_lines', 'trim_whitespace']
