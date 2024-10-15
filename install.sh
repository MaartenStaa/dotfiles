#!/bin/zsh

echo "Setting up your Mac..."

# Install NixOS
sh <(curl -L https://nixos.org/nix/install)
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.dotfiles/nix#mbp
darwin-rebuild switch --flake ~/.dotfiles/nix#mbp

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
