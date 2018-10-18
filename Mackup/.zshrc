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
# export NVM_DIR="$HOME/.nvm"
# . "/usr/local/opt/nvm/nvm.sh"
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

lazynvm() {
  unset -f nvm node npm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
}

nvm() {
  lazynvm 
  nvm $@
}

node() {
  lazynvm
  node $@
}

npm() {
  lazynvm
  npm $@
}

# Editors
export EDITOR='vim'
export GIT_EDITOR='vim'
export VISUAL='vim'

# Aliases
alias gs="git status"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

# Keybindings
bindkey '^ ' autosuggest-accept
bindkey '^r' history-incremental-search-backward

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

