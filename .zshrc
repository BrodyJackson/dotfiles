source ~/.nvm/nvm.sh
source ~/.sensitive
export PATH=$PATH:~/kubectl-plugins
eval "$(pyenv init -)"

#Make sure that tmux uses vim colors rather than it's own
alias tmux='tmux -2'

# Export terminal colors
export TERM="xterm-256color"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=2000
setopt appendhistory
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
# zstyle :compinstall filename '/Users/ccyr/.zshrc'
 
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Enable Delete Forward Key
bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char

fpath=(/usr/local/share/zsh-completions $fpath)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

source ~/.powerlevel9krc
POWERLEVEL9K_MODE='nerdfont-complete'
source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time load ram time)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0.5

command -v helm > /dev/null 2>&1 && source <(helm completion zsh)
command -v kubectl > /dev/null 2>&1 && source <(kubectl completion zsh) && compdef k='kubectl'
alias k='kubectl'

#Kubernetes Tools zsh completion start
autoload -U compaudit compinit bashcompinit
compaudit && compinit && bashcompinit
source /usr/local/Cellar/kubernetes-tools/2.1.0/completion/__completion
#Kubernetes Tools zsh completion end

# Aliases
alias ls='ls -G'
alias ll='ls -l'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Custom functions

# Run python file with arguments held in runtime configuration
runpy () {
  python $1 $(cat ~/dev/runConfigs/$2)
}

alias gd="git diff -- . ':!package-lock.json' ':!yarn.lock'"
alias dotfiles='/usr/bin/git --git-dir=/Users/brody.jackson/.dotfiles/ --work-tree=/Users/brody.jackson'
