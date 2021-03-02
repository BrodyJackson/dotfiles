# Setup python
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# Setup Node
echo 'source ~/.nvm/nvm.sh' >> ~/.zshrc

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
