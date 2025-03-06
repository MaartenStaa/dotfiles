# Disable the default fish greeting.
set -g fish_greeting

# Vi mode.
fish_vi_key_bindings

# Keybindings
bind -k nul -M insert end-of-line
bind \cF -M insert nextd-or-forward-word

# Set $PATH variable.
fish_add_path -m /run/current-system/sw/bin
fish_add_path -p ~/.nix-profile/bin /nix/var/nix/profiles/default/bin /etc/profiles/per-user/maartens/bin
fish_add_path $USER/.cargo/bin
fish_add_path /Applications/kitty.app/Contents/MacOS/
fish_add_path $USER/.yarn/bin
fish_add_path $USER/.local/bin
fish_add_path $USER/.fig/bin
fish_add_path /opt/homebrew/bin

# SPT CONFIG BEGIN
fish_add_path ~/.local/bin
# SPT CONFIG END

if status is-interactive; and test $TERM != dumb
    # Transient prompt with starship
    enable_transience
end
