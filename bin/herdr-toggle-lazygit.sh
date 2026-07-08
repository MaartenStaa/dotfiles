#!/usr/bin/env bash
set -euo pipefail

current=$(herdr pane current 2>/dev/null)
workspace_id=$(echo "$current" | jq -r '.result.pane.workspace_id')
current_tab=$(echo "$current" | jq -r '.result.pane.tab_id')

lazygit_tab=$(herdr tab list --workspace "$workspace_id" 2>/dev/null | \
    jq -r '.result.tabs[] | select(.label == "lazygit") | .tab_id // empty')

state_file="${TMPDIR:-/tmp}/herdr-lazygit-return-${workspace_id}"

if [ -n "$lazygit_tab" ] && [ "$current_tab" = "$lazygit_tab" ]; then
    prev_tab=$(cat "$state_file" 2>/dev/null || true)
    [ -n "$prev_tab" ] && herdr tab focus "$prev_tab" 2>/dev/null || true
elif [ -n "$lazygit_tab" ]; then
    echo "$current_tab" > "$state_file"
    herdr tab focus "$lazygit_tab" 2>/dev/null
else
    echo "$current_tab" > "$state_file"
    new=$(herdr tab create --workspace "$workspace_id" --label lazygit --focus 2>/dev/null)
    pane_id=$(echo "$new" | jq -r '.result.root_pane.pane_id')
    herdr pane run "$pane_id" "exec lazygit"
fi
