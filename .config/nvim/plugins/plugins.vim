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
  " Plug 'airblade/vim-rooter'
  " Auto Pairing for ( { [ ] } )
  Plug 'jiangmiao/auto-pairs'
  " Closing tags in HTML
  Plug 'alvan/vim-closetag'
  "Status Line configuration
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'akinsho/bufferline.nvim'
  "Icons
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ryanoasis/vim-devicons'
  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  Plug 'rhysd/git-messenger.vim'
  " Floating Terminal 
  Plug 'voldikss/vim-floaterm'
  " Start Screen
  Plug 'glepnir/dashboard-nvim'
  "Plug 'mhinz/vim-startify'
  " View tag info with support for both LSP and universal ctags
  Plug 'liuchengxu/vista.vim'
  " Get a popup which explains what certain key presses do after leader
  Plug 'liuchengxu/vim-which-key'
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
  " fuzzy find with telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  " Fuzzy find
  " Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Plug 'junegunn/fzf.vim'
  " <3 COC 
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " More Syntax support
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " Turned off polyglot in order to try native treesitter
  " Plug 'sheerun/vim-polyglot'
  " Commenting support
  Plug 'tpope/vim-commentary'
  " Focus Mode
  Plug 'junegunn/goyo.vim'
  " debugger
  Plug 'mfussenegger/nvim-dap'
  " window maximizer
  Plug 'szw/vim-maximizer' 
  "" THEMES
  Plug 'dracula/vim'
  Plug 'morhetz/gruvbox'
  Plug 'ayu-theme/ayu-vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'Rigellute/rigel'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'NLKNguyen/papercolor-theme'
call plug#end()
