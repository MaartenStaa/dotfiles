# Vi mode.
fish_vi_key_bindings

# Keybindings
bind -k nul -M insert end-of-line
bind \cF -M insert nextd-or-forward-word

# Environment
export EDITOR=$(which nvim)
export VISUAL=$(which nvim)
export BAT_THEME=OneHalfDark

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# pnpm
set -gx PNPM_HOME /Users/maartens/Library/pnpm
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

# Set $PATH variable.
fish_add_path -m /run/current-system/sw/bin
fish_add_path $USER/.cargo/bin
fish_add_path /Applications/kitty.app/Contents/MacOS/
fish_add_path $USER/.yarn/bin
fish_add_path $USER/.local/bin
fish_add_path $USER/.fig/bin
fish_add_path /opt/homebrew/bin

# Abbreviations
abbr -a -- dcr 'docker compose run app'
abbr -a -- dc 'docker compose'
abbr -a -- dce 'docker compose run app'
abbr -a -- dcb 'docker compose build'
abbr -a -- gc 'git commit'
abbr -a -- gco 'git checkout'
abbr -a -- yup 'yarn submodules && yarn install --frozen-lockfile'
abbr -a -- dcu 'docker compose up'
abbr -a -- brewu 'brew update && brew upgrade'
abbr -a -- gb 'git branch'
abbr -a -- dcsh 'docker compose exec app ash'
abbr -a -- giA 'git add -p'
abbr -a -- gia 'git add'
abbr -a -- gwd 'git diff --no-ext-diff'
abbr -a -- gid 'git diff --no-ext-diff --cached'
abbr -a -- gl 'git log'
abbr -a -- gcn 'git commit --no-edit'
abbr -a -- gp 'git push'
abbr -a -- ll 'eza -hal'
abbr -a -- gpf 'git push --force-with-lease'
abbr -a -- gs 'git status'
abbr -a -- ls eza
abbr -a -- psi 'pnpm submodules && pnpm install --frozen-lockfile'
abbr -a -- vim nvim
abbr -a -- code /Applications/Visual\\\ Studio\\\ Code.app/Contents/Resources/app/bin/code
abbr -a -- cat bat
abbr -a -- pn pnpm
abbr -a -- subl /Applications/Sublime\\\ Text.app/Contents/SharedSupport/bin/subl
abbr -a -- art 'php artisan'
abbr -a -- lg lazygit

function gh_pr_comments --description 'Print comments for all open PRs for the current user'
    gh pr list -A $(id -un) -s open --json number --jq ".[].number" | xargs -I {} gh pr view {} --comments --json title,comments --jq '.comments |= map(select(.author.login | test("bot|ci") | not)) | .comments |= map(.body) | .title,.comments' | bat
end

# zoxide
source "$HOME/.config/fish/zoxide.fish"

# fisher
source "$HOME/.config/fish/functions/fisher.fish"
fish_add_path /Users/maartens/.jenv/bin

# SPT CONFIG BEGIN
function spt
    fish -c 'cd "$(git rev-parse --show-toplevel)" && ./tools/sptcli/src/sptcli.py $argv'
end
# SPT CONFIG END
