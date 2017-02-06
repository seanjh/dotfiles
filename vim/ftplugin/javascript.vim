highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.js,*.jsx,*.json match BadWhitespace /\s\+$/
