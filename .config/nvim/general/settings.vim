""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set relativenumber
set nu
set noerrorbells
set hidden
set ruler
set encoding=utf-8
set fileencoding=utf-8
set mouse=a
"tab and spacing related
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set smarttab
set cursorline
set t_Co=256" support 256 colours
set splitbelow splitright
set nowrap
set smartcase
set undodir=~/.config/neovim/undodir//
set directory=~/.config/neovim/swap//
set nobackup" This is recommended by coc
set nowritebackup" This is recommended by coc
set undofile
set cmdheight=2
set updatetime=50
set timeoutlen=500
set ttimeoutlen=100
set smartcase
set colorcolumn=100
set incsearch
set termguicolors
set signcolumn=yes" Needed for git solution that uses sign column
set scrolloff=8
set noshowmode
set numberwidth=1 "set the number column right beside the gutter (default is 4)
set clipboard=unnamedplus" Use the system clipboard
set guifont=Fira\ Code\ Nerd\ Font

"control the completion menu function
set completeopt=menuone,noinsert,noselect

"Dont give any message to |ins-completion-menu|
set shortmess+=c
