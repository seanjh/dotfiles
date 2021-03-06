let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 1
let g:ale_echo_msg_format = '[%linter%][%severity%] %s'

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

let g:ale_pattern_options = {
\   '.*(node_modules|venv|direnv)/.*': {'ale_enabled': 0},
\}
