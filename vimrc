" ##############################################################################
" Vim / NVim configuration
" ##############################################################################

call plug#begin('~/.vim/plugged')
Plug 'mattn/emmet-vim'
Plug 'crusoexia/vim-monokai'
Plug 'tpope/vim-surround'
call plug#end()

set nocompatible
set number
:filetype on
syntax enable
set showmatch
set wrap
set textwidth=120
set hlsearch
set ruler
set cursorline
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent

set termguicolors
syntax enable
colorscheme monokai
highlight Normal guibg=#051b29
highlight LineNr guibg=#051b29