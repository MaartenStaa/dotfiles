#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# lazynvm() {
  # unset -f nvm node npm yarn
  # export NVM_DIR="$HOME/.nvm"
  # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# }
#
# nvm() {
  # lazynvm
  # nvm $@
# }
#
# node() {
  # lazynvm
  # node $@
# }
#
# npm() {
  # lazynvm
  # npm $@
# }
#
# yarn() {
  # lazynvm
  # yarn $@
# }

# Editors
export EDITOR='nvim'
export GIT_EDITOR='nvim'
export VISUAL='nvim'

# Aliases
alias art="php artisan"
alias gs="git status"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
alias vim="nvim"

# Keybindings
bindkey '^ ' autosuggest-accept
bindkey '^r' history-incremental-search-backward
# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# For VIM mode
# https://dougblack.io/words/zsh-vi-mode.html
zstyle ':prezto:module:editor' ps-context 'yes'
zstyle ':prezto:module:editor:info:keymap:primary' format '[NORMAL]'
zstyle ':prezto:module:editor:info:keymap:alternate' format '[ALT]'
zstyle ':prezto:module:editor:info:keymap:primary:overwrite' format '[OVERWRITE]'

function zle-line-init zle-keymap-select {
  VIM_PROMPT="%F{yellow} $editor_info[keymap]%f"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$EPS1"
  zle reset-prompt
}

export KEYTIMEOUT=1


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export YVM_DIR=/Users/maartens/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
