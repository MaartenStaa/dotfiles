# Vi mode.
fish_vi_key_bindings

# NVM.
function nvm
    bass source ~/.nvm/nvm.sh ';' nvm $argv
end

# Set $PATH variable.
set -U fish_user_paths ~/.cargo/bin $fish_user_paths

# Keybindings
bind -k nul -M insert end-of-line
