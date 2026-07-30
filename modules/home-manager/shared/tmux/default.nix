{ pkgs, ... }:
{
  # https://mynixos.com/nixpkgs/options/programs.tmux
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    extraConfig = builtins.readFile ./tmux.conf + ''
      set-option -g default-shell ${pkgs.fish}/bin/fish
      set-option -g default-command \$SHELL
    '';
    historyLimit = 10000;
    keyMode = "vi";
    newSession = true;
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      continuum
      copycat
      open
      prefix-highlight
      resurrect
      # tpm
    ];
    shortcut = "a";
  };
}
