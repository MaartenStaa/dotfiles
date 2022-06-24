# Vi mode.
fish_vi_key_bindings

# Set $PATH variable.
set -U fish_user_paths ~/.cargo/bin $fish_user_paths

# Keybindings
bind -k nul -M insert end-of-line
bind \cF -M insert nextd-or-forward-word

# Environment
export EDITOR=/usr/local/bin/nvim
export VISUAL=/usr/local/bin/nvim

