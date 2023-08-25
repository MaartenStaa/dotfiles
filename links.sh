#!/bin/zsh

echo "Linking configuration files..."

link () {
  SOURCE=~/.dotfiles/$1
  TARGET=~/$1

  if [ ! -L $TARGET ]; then
    ln -s $SOURCE $TARGET
  fi
}

link ".ideavimrc"
link ".fdignore"
link ".mackup.cfg"
link ".tmux.conf"
link ".config/fish"
link ".config/karabiner"
link ".config/kitty"
link ".config/omf"
link ".config/nvim"
