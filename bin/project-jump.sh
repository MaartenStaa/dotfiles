#!/usr/bin/env bash

set -e

function main() {
  # Find all project directories
  local base_dir
  base_dir="/Users/$USER/repos/"

  local all_projects
  all_projects=$(find $base_dir{,github} -type d -maxdepth 2 -depth 2 | sed -E "s#$base_dir##")

  # Construct a command that will take one of the above items and give a preview
  # of the pane. This is the command that will be run when the user selects an
  # item. The command should contain `{}`, which will be replaced with the
  # selected item.
  local preview_command
  preview_command="exa -al '$base_dir{}'"

  # Open tmux popup to select a pane, using fzf
  local selected_item
  selected_item=$(echo "$all_projects" | fzf-tmux -p -w 75% -h 75% -- --reverse --prompt="Open project: " --preview="$preview_command" || true)
  if [[ -n "$selected_item" ]]; then
    local project_name
    project_name=$(echo "$selected_item" | rev | cut -d '/' -f 1 | rev)
    $(tmux new-window -c "$base_dir$selected_item" -n "$project_name")
  fi

  exit 0
}

main "$@"

