#!/bin/zsh

echo "Linking configuration files..."

link () {
  SOURCE=~/.dotfiles/$1
  TARGET=~/$1

  if [ ! -h $TARGET ]; then
    ln -s $SOURCE $TARGET
  fi
}

link ".mackup.cfg"
link ".tmux.conf"
link ".vimrc"
link ".config/fish"
link ".config/karabiner"
link ".config/omf"
link ".config/nvim"
link ".vim"
