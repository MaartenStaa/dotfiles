# Disable the default fish greeting.
set -g fish_greeting

# Vi mode.
fish_vi_key_bindings

# Keybindings
bind ctrl-space -M insert end-of-line
bind ctrl-f -M insert nextd-or-forward-word

# Set $PATH variable.
fish_add_path -m /run/current-system/sw/bin
fish_add_path ~/.nix-profile/bin /nix/var/nix/profiles/default/bin /etc/profiles/per-user/maartens/bin
fish_add_path $HOME/.cargo/bin
fish_add_path /Applications/kitty.app/Contents/MacOS/
fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/bin

if test -d /run/wrappers/bin
    fish_add_path -m /run/wrappers/bin
end

if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end

if status is-interactive; and test $TERM != dumb
    # Transient prompt with starship
    enable_transience
end

# if in herdr and TERM is xterm-256color, set TERM to xterm-ghostty
# herdr uses libghostty, so this is more accurate, and provides better capability
# detection for programs like neovim.
if test "$HERDR_ENV" = 1 -a "$TERM" = xterm-256color
    set -gx TERM xterm-ghostty
end
