# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.nvm/nvm.sh
source ~/.sensitive

# Manage python versions with pyenv
eval "$(pyenv init -)"

# Export terminal colors
export TERM="xterm-256color"

# globbing completetion is case insensitive
setopt NO_CASE_GLOB
# no need to type cd
setopt AUTO_CD
# setup history options for zsh,
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=2000
setopt APPEND_HISTORY
# share history between multiple instances
setopt SHARE_HISTORY
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST 
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS
# append to history after each command rather than on exit
setopt INC_APPEND_HISTORY

bindkey -e
# Enable Delete Forward Key
bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char

# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
#Turn on completions
autoload -Uz compinit && compinit

#turn on autojump
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh
#turn on autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#turn on syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias k='kubectl'
alias k9s='docker run --rm -it -v ${HOME}/.kube/config:/root/.kube/config quay.io/derailed/k9s'

alias gd="git diff -- . ':!package-lock.json' ':!yarn.lock'"
alias dotfiles='/usr/bin/git --git-dir=/Users/brody.jackson/.dotfiles/ --work-tree=/Users/brody.jackson'
alias lazydotfiles='lazygit --git-dir=/Users/brody.jackson/.dotfiles/ --work-tree=/Users/brody.jackson'

#Make sure that tmux uses vim colors rather than it's own
alias tmux='tmux -2'

alias ls='ls -G'
alias ll='ls -l'

source ~/.personalScripts.sh

# Run python file with arguments held in runtime configuration
runpy () {
  python $1 $(cat ~/dev/runConfigs/$2)
}

# Source powerlevel10k
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
