#!/usr/bin/env bash

set -e

function main() {
  # Ask tmux for all sessions, windows, and panes
  # Format:
  #  session_name
  #  session_name:window_name#window_index
  #  session_name:window_name#window_index.pane_index

  # shellcheck disable=SC2046
  local all_panes
  all_panes=$(tmux list-panes -a -F "#{session_name}:#{window_name}###{window_index}.#{pane_index}")

  # echo ""
  # echo "Found panes:"
  # for item in "${all_items[@]}"; do
  #   echo "$item"
  # done

  # Format for fzf-tmux, which expects a newline-separated list of items.
  local with_newlines
  with_newlines=$(echo "${all_panes[@]}" | tr ' ' '\n')

  # Construct a command that will take one of the above items and give a preview
  # of the pane. This is the command that will be run when the user selects an
  # item. The command should contain `{}`, which will be replaced with the
  # selected item.
  # Note that we need to convert the `session_name:window_name#window_index.pane_index`
  # format to `session_name:window_index.pane_index` for tmux's `capture-pane`
  # command.
  local preview_command
  preview_command="echo '{}' | sed -E 's/:.+#/:/' | xargs tmux capture-pane -E- -S25 -J -e -pt"

  # Open tmux popup to select a pane, using fzf
  local selected_item
  selected_item=$(echo "$with_newlines" | fzf-tmux -p -w 75% -h 75% -- --reverse --prompt="Jump to: " --preview="$preview_command" || true)
  if [[ -n "$selected_item" ]]; then
    $(echo "$selected_item" | sed -E 's/:.+#/:/' | xargs tmux switch-client -t)
  fi

  exit 0
}

main "$@"
