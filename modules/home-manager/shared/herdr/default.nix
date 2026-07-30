{
  inputs,
  system,
  pkgs,
  ...
}:
let
  pluginDefs = import ./plugins.nix { inherit pkgs inputs; };

  sessions = [
    "default"
    "admin"
    "open-source"
  ];

  pluginsJsonForSession =
    session:
    let
      relevant = builtins.filter (p: builtins.elem session p._sessions) pluginDefs;
      cleaned = map (p: builtins.removeAttrs p [ "_sessions" ]) relevant;
    in
    builtins.toJSON cleaned;

  pluginJsonFiles = builtins.listToAttrs (
    map (session: {
      name =
        if session == "default" then "herdr/plugins.json" else "herdr/sessions/${session}/plugins.json";
      value = {
        text = pluginsJsonForSession session;
      };
    }) sessions
  );
in
{
  programs.herdr = {
    enable = true;
    package = inputs.herdr.packages.${system}.default;
    settings = {
      onboarding = false;
      update.version_check = false;
      worktrees.directory = "~/src/worktrees/";
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
          {
            key = "ctrl+shift+p";
            type = "plugin_action";
            command = "jt.command-palette.open";
            description = "Command palette";
          }
        ];
      };
      terminal.default_shell = "fish";
      experimental.pane_history = true;
      session.resume_agents_on_restore = true;
      theme.custom = {
        panel_bg = "#24273a";
        accent = "#8aadf4";
        green = "#a6da95";
        red = "#ed8796";
        yellow = "#eed49f";
      };
      ui = {
        agent_panel_sort = "priority";
        show_agent_labels_on_pane_borders = true;
        hide_tab_bar_when_single_tab = true;
      };
    };
  };

  xdg.configFile = pluginJsonFiles;
}
