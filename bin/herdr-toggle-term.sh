#!/usr/bin/env bash
set -euo pipefail

layout=$(herdr pane layout --current 2>/dev/null)
pane_count=$(echo "$layout" | jq '.result.layout.panes | length')
zoomed=$(echo "$layout" | jq '.result.layout.zoomed')

if [ "$pane_count" -eq 1 ]; then
  herdr pane split --current --direction right --ratio 0.33 --focus
elif [ "$zoomed" = "true" ]; then
  herdr pane zoom --current --toggle
  herdr pane focus --direction right
else
  main_pane=$(echo "$layout" | jq -r '.result.layout.panes | sort_by(.rect.x) | .[0].pane_id')
  herdr pane zoom "$main_pane" --on
fi
