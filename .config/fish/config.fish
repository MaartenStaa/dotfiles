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


# Abbreviations
abbr -a -- dcr 'docker compose run app'
abbr -a -- mcu 'mutagen compose up'
abbr -a -- dc 'docker compose'
abbr -a -- dce 'docker compose run app'
abbr -a -- dcb 'docker compose build'
abbr -a -- gc '/Users/maartens/repos/pdx-insights/gitt/gitt commit'
abbr -a -- gco '/Users/maartens/repos/pdx-insights/gitt/gitt checkout'
abbr -a -- yup 'yarn submodules && yarn install --frozen-lockfile'
abbr -a -- dcu 'docker compose up'
abbr -a -- brewu 'brew update && brew upgrade'
abbr -a -- gb '/Users/maartens/repos/pdx-insights/gitt/gitt branch'
abbr -a -- dcsh 'docker compose exec app ash'
abbr -a -- giA '/Users/maartens/repos/pdx-insights/gitt/gitt add -p'
abbr -a -- gia '/Users/maartens/repos/pdx-insights/gitt/gitt add'
abbr -a -- gwd '/Users/maartens/repos/pdx-insights/gitt/gitt diff --no-ext-diff'
abbr -a -- mc 'mutagen compose'
abbr -a -- gid '/Users/maartens/repos/pdx-insights/gitt/gitt diff --no-ext-diff --cached'
abbr -a -- gl '/Users/maartens/repos/pdx-insights/gitt/gitt log'
abbr -a -- gcn '/Users/maartens/repos/pdx-insights/gitt/gitt commit --no-edit'
abbr -a -- gp '/Users/maartens/repos/pdx-insights/gitt/gitt push'
abbr -a -- ll 'exa -hal'
abbr -a -- gpf '/Users/maartens/repos/pdx-insights/gitt/gitt push --force-with-lease'
abbr -a -- gs '/Users/maartens/repos/pdx-insights/gitt/gitt status'
abbr -a -- ls exa
abbr -a -- psi 'pnpm submodules && pnpm install --frozen-lockfile'
abbr -a -- vim nvim
abbr -a -- code /Applications/Visual\\\ Studio\\\ Code.app/Contents/Resources/app/bin/code
abbr -a -- cat bat
abbr -a -- pn pnpm
abbr -a -- subl /Applications/Sublime\\\ Text.app/Contents/SharedSupport/bin/subl
abbr -a -- art 'php artisan'
abbr -a -- git /Users/maartens/repos/pdx-insights/gitt/gitt
abbr -a -- lg lazygit

