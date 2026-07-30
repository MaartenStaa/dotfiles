use std/util "path add"

# Set $PATH variable.
# path add -m /run/current-system/sw/bin
# path add -p ~/.nix-profile/bin /nix/var/nix/profiles/default/bin /etc/profiles/per-user/maartens/bin
path add "~/.cargo/bin"
path add "/Applications/kitty.app/Contents/MacOS/"
path add "~/.yarn/bin"
path add "~/.local/bin"
path add "/opt/homebrew/bin"

# Initialize starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
