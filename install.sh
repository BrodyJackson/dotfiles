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
brew install git
brew install pyenv
brew install the_silver_searcher
brew install ripgrep
brew install neovim
brew install tmux
brew install tmuxinator
brew install lazygit
brew install lazydocker
brew install zlib
brew install jq

##Zsh extenstions
brew install autojump
brew install romkatv/powerlevel10k/powerlevel10k
brew install zsh-autosuggestions
brew install zsh-completions
brew install zsh-syntax-highlighting

brew install --cask google-chrome
brew install --cask slack
brew install --cask firefox
brew install --cask kitty
#you will most likely need to provide additional permissions for karabiner to work. Opening it and following instructions shuold work
brew install --cask karabiner-elements

brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-hack-nerd-font

# Make dev directory
[[ ! -d Dev ]] && mkdir Dev

# Zsh Configuration
chsh -s /usr/local/bin/zsh

#Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
nvm install node
nvm use node
npm install -g neovim

#Setup python
pyenv install 3.9.1

#Tmux
tmux source ~/.tmux.conf

#Install Vim-Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
#Install nvim plugins
nvim +PlugInstall

# Mac OS defaults
defaults write NSGlobalDomain KeyRepeat -int 1
