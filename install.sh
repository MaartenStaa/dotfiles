#!/bin/zsh

echo "Setting up your Mac..."

# Install Homebrew if it's not installed yet.
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew
brew update

# Install Homebrew dependencies from Brewfile
brew tap homebrew/bundle
brew bundle

# Install Prezto if it's not there yet.
if [ ! -d ~/.zprezto ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

# Pull Tmux plugin manager if it's not there yet.
if [ ! -d ~/.tmux/plugins/tpm ]; then
  mkdir -p ~/.tmux/plugins/tpm
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Link configuration files.
$ZSH=$(which zsh)
$ZSH links.sh

# Restore configuration files.
$ZSH bin/dot-restore.sh

# Make ZSH the default shell environment
if [ $SHELL != $ZSH ]; then
  echo "Changing shell to zsh..."
  chsh -s $ZSH
fi
