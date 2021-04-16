"Brody yackson NeoVim Config


" Polyglot config needs to come first
source $HOME/.config/nvim/plug-configs/polyglot.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings and Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/plugins/plugins.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/.config/nvim/general/mappings/mappings.vim
source $HOME/.config/nvim/general/mappings/which-key.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/.config/nvim/plug-configs/coc.vim
source $HOME/.config/nvim/plug-configs/fzf.vim
source $HOME/.config/nvim/plug-configs/rnvimr.vim
source $HOME/.config/nvim/plug-configs/start-screen.vim
source $HOME/.config/nvim/plug-configs/git-messenger.vim
source $HOME/.config/nvim/plug-configs/vim-commentary.vim
source $HOME/.config/nvim/plug-configs/gitgutter.vim
source $HOME/.config/nvim/plug-configs/rainbow.vim
source $HOME/.config/nvim/plug-configs/ranger.vim
source $HOME/.config/nvim/plug-configs/tagalong.vim
source $HOME/.config/nvim/plug-configs/vim-rooter.vim
source $HOME/.config/nvim/plug-configs/vista.vim
source $HOME/.config/nvim/plug-configs/window-swap.vim
source $HOME/.config/nvim/plug-configs/start-screen.vim
source $HOME/.config/nvim/plug-configs/closetags.vim
source $HOME/.config/nvim/plug-configs/vimspector.vim


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Themes 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" source $HOME/.config/nvim/general/themes/dracula.vim
source $HOME/.config/nvim/general/themes/airline.vim
source $HOME/.config/nvim/general/themes/themer.vim
" colorscheme gruvbox

set background=dark
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_sign_column = "bg0"
let g:gruvbox_invert_selection =0
let g:airline_theme = "gruvbox"

" set termguicolors
" colorscheme ayu
" let ayucolor="light"
" let g:airline_theme = 'ayu'
