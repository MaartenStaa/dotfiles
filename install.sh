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

# Install NVM
if [ ! -d ~/.nvm ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
fi

# Link configuration files.
$ZSH=$(which zsh)
$ZSH links.sh

# Add Cargo and related packages.
rustup install stable
cargo install exa

# Restore configuration files.
$ZSH bin/dot-restore.sh

# Install oh-my-fish and things.
fish omf.fish

# Install patched tmux-256color terminfo for Kitty (with undercurl support)
sudo tic -xe tmux-256color tmux256color.info

# Make Fish the default shell environment
$FISH=$(which fish)
if [ $SHELL != $FISH ]; then
  echo "Changing shell to fish..."
  chsh -s $FISH
fi
