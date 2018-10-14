#!/bin/zsh
mackup restore

CODE=/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code
cat ~/.dotfiles/Mackup/vscode-extensions | xargs -L 1 $CODE --install-extension
