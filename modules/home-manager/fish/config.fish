# Disable the default fish greeting.
set -g fish_greeting

# Vi mode.
fish_vi_key_bindings

# Keybindings
bind ctrl-space -M insert end-of-line
bind ctrl-f -M insert nextd-or-forward-word

# Set $PATH variable.
fish_add_path -m /run/current-system/sw/bin
fish_add_path -p ~/.nix-profile/bin /nix/var/nix/profiles/default/bin /etc/profiles/per-user/maartens/bin
fish_add_path $USER/.cargo/bin
fish_add_path /Applications/kitty.app/Contents/MacOS/
fish_add_path $USER/.yarn/bin
fish_add_path $USER/.local/bin
fish_add_path $USER/.fig/bin
fish_add_path /opt/homebrew/bin

if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end

if status is-interactive; and test $TERM != dumb
    # Transient prompt with starship
    enable_transience
end
