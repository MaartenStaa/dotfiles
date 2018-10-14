#!/bin/sh

echo "Setting up your Mac..."

# Install Homebrew if it's not installed yet.
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew
brew update

# Install Homebrew dependencies from Brewfile
brew tap homebrew/bundle
# brew bundle

# Make ZSH the default shell environment
if [ -z $ZSH_VERSION ]; then
  chsh -s $(which zsh)
fi
