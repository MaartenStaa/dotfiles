# Install OMF
curl -L https://get.oh-my.fish | fish

# Install theme and plugins
omf install \
    bang-bang \
    bass \
    eclm \
    fish-spec \
    foreign-env \
    nvm

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
omf install nvm
