" ---- Behavior ----
set nocompatible              " disable vi compatibility
set encoding=utf-8
set hidden                    " allow switching buffers without saving
set history=1000
set undolevels=1000
set undofile                  " persistent undo
set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set autoread                  " reload files changed outside vim
set backspace=indent,eol,start
set ttimeoutlen=50            " faster escape from insert mode
set updatetime=300

" ---- Display ----
syntax on
filetype plugin indent on
set number
set relativenumber
set ruler
set showcmd
set showmatch                 " highlight matching brackets
set laststatus=2              " always show statusline
set wildmenu
set wildmode=longest:full,full
set scrolloff=8               " keep cursor 8 lines from edge
set sidescrolloff=8
set display=lastline
set lazyredraw                " don't redraw during macros
set termguicolors

" ---- Search ----
set ignorecase
set smartcase                 " case-sensitive if uppercase used
set incsearch
set hlsearch

" ---- Indentation ----
set expandtab                 " spaces, not tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set shiftround                " round indent to multiple of shiftwidth

" ---- Whitespace ----
set list
set listchars=tab:»·,trail:·,nbsp:␣,extends:›,precedes:‹

" ---- Splits ----
set splitright
set splitbelow

" ---- Mouse ----
set mouse=a

" ---- Leader & basic mappings ----
let mapleader = " "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader><space> :nohlsearch<CR>

" Move by visual line, not logical line
nnoremap j gj
nnoremap k gk

" Saner split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ---- Filetype-specific tweaks ----
autocmd FileType python setlocal ts=4 sw=4 sts=4
autocmd FileType go setlocal ts=4 sw=4 sts=4 noexpandtab
autocmd FileType make setlocal noexpandtab
autocmd FileType markdown setlocal wrap linebreak nolist
autocmd BufWritePre * %s/\s\+$//e

set background=dark
silent! colorscheme habamax
