{ inputs, system, ... }:
{
  programs.herdr = {
    enable = true;
    package = inputs.herdr.packages.${system}.default;
    settings = {
      onboarding = false;
      update.version_check = false;
      keys = {
        prefix = "ctrl+a";
        split_vertical = "prefix+\\";
        split_horizontal = "prefix+minus";
        navigate_workspace_up = "k";
        navigate_workspace_down = "j";
        command = [
          {
            key = "alt+t";
            type = "shell";
            command = "~/.dotfiles/bin/herdr-toggle-term.sh";
            description = "toggle a right-hand terminal pane";
          }
          {
            key = "alt+l";
            type = "shell";
            command = "~/.dotfiles/bin/herdr-toggle-lazygit.sh";
            description = "toggle a tab running lazygit";
          }
        ];
      };
      terminal.default_shell = "fish";
      experimental.pane_history = true;
      session.resume_agents_on_restore = true;
      theme.custom = {
        panel_bg = "#24273a"; # Base
        accent = "#8aadf4"; # Blue
        green = "#a6da95"; # Green
        red = "#ed8796"; # Red
        yellow = "#eed49f"; # Yellow
      };
      ui = {
        agent_panel_sort = "priority";
        show_agent_labels_on_pane_borders = true;
        hide_tab_bar_when_single_tab = true;
      };
    };
  };
}
