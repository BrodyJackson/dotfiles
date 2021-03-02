#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
# source: https://gist.github.com/cowboy/3118588
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Lots of scripts suggest to add scripts here which install core utils that override mac commands with linux ones
# I haven't done that here, but could add in the future if needed

brew install wget
brew install zsh
brew install nvm
brew install git
brew install pyenv
brew install the_silver_searcher
brew install ripgrep
brew install neovim
brew install tmux
brew install tmuxinator
brew install lazygit
brew install lazydocker

##Zsh extenstions
brew install autojump
brew install powerlevel9k
brew install zsh-autosuggestions
brew install zsh-completions
brew install zsh-syntax-highlighting

brew install --cask google-chrome
brew install --cask slack
brew install --cask firefox
brew install --cask kitty

brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-hack-nerd-font

# Make dev directory
[[ ! -d Dev ]] && mkdir Dev

# Zsh Configuration
chsh -s /usr/local/bin/zsh

# Setup python
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
brew install zlib

# Setup Node
echo 'source ~/.nvm/nvm.sh' >> ~/.zshrc
nvm install node

# Setup Fzf
echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> ~/.zshrc

cat > ~/.zshrc << EoM
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=2000
setopt appendhistory
bindkey -e

# The following lines were added by compinstall
autoload -Uz compinit
compinit

# Enable Delete Forward Key
bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char
EoM

echo "fpath=($(brew --prefix)/share/zsh-completions \$fpath)" >> ~/.zshrc
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
echo '[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh' >> ~/.zshrc

echo 'source ~/.powerlevel9krc' >> ~/.zshrc
cat > ~/.powerlevel9krc << EoM
POWERLEVEL9K_MODE='nerdfont-complete'
source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time kubecontext time)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0.5
EoM

# Setup Aliases
cat > ~/.zshrc << EoM
# Aliases
alias ls='ls -G'
alias ll='ls -l'
# make sure that tmux uses vim colors rather than it's own
alias tmux='tmux -2'
alias gd="git diff -- . ':!package-lock.json' ':!yarn.lock'"
# This one is important for getting dotfile git repo working
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# Export terminal colors
export TERM="xterm-256color"
EoM

cat > ~/.zshrc << EoM
# Custom functions

# Run python file with arguments held in runtime configuration
runpy () {
  python $1 $(cat ~/dev/runConfigs/$2)
}
EoM

#Tmux
tmux source ~/.tmux.conf

#Install Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#Install nvim plugins
nvim +PlugInstall

# Mac OS defaults
defaults write NSGlobalDomain KeyRepeat -int 1
