""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Begin the plugin section using Vim Plug
call plug#begin("~/.vim/plugged")
  " Surround Plugin
  Plug 'tpope/vim-surround'
  " Dealing with Files
  Plug 'tpope/vim-eunuch'
  " Identify and auto change the working directory to file parent
  Plug 'airblade/vim-rooter'
  " Auto Pairing for ( { [ ] } )
  Plug 'jiangmiao/auto-pairs'
  " Closing tags in HTML
  Plug 'alvan/vim-closetag'
  " Delete the nerdree plugins once COC-explorer is setup 
  Plug 'scrooloose/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  "Status Line configuration
  Plug 'vim-airline/vim-airline'
  " Ranger File Explorer
  Plug 'kevinhwang91/rnvimr'
  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  Plug 'rhysd/git-messenger.vim'
  " Floating Terminal 
  Plug  'voldikss/vim-floaterm'
  " Start Screen
  Plug 'mhinz/vim-startify'
  " View tag info with support for both LSP and universal ctags
  Plug 'liuchengxu/vista.vim'
  " Get a popup which explains what certain key presses do after leader
  Plug 'liuchengxu/vim-which-key'
  " Custom snippets when coding
  Plug 'honza/vim-snippets'
  " More detailed undo history
  Plug 'mbbill/undotree'
  " Auto close html tags
  Plug 'AndrewRadev/tagalong.vim'
  " Swap one window with another using leader ww, they switch
  Plug 'wesQ3/vim-windowswap'
  " Highlight hex colours
  Plug 'norcalli/nvim-colourizer.lua'
  " Rainbow brackets
  Plug 'luochen1990/rainbow'
  " Icons
  Plug 'ryanoasis/vim-devicons'
  " Fuzzy find
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " <3 COC 
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " More Syntax support
  Plug 'sheerun/vim-polyglot'
  " Commenting support
  Plug 'tpope/vim-commentary'
  " Focus Mode
  Plug 'junegunn/goyo.vim'
  " debugger
  Plug 'puremourning/vimspector'
  " window maximizer
  Plug 'szw/vim-maximizer' 
  "" THEMES
  Plug 'dracula/vim'
  Plug 'morhetz/gruvbox'
  Plug 'ayu-theme/ayu-vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'Rigellute/rigel'
  Plug 'vim-airline/vim-airline-themes'
call plug#end()
