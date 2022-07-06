#!/bin/zsh

echo "Downloading Vim Plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Linking configuration files..."

link () {
  SOURCE=~/.dotfiles/$1
  TARGET=~/$1

  if [ ! -h $TARGET ]; then
    ln -s $SOURCE $TARGET
  fi
}

link ".ideavimrc"
link ".mackup.cfg"
link ".tmux.conf"
link ".config/fish"
link ".config/karabiner"
link ".config/kitty"
link ".config/omf"
link ".config/nvim"
link ".vim"
