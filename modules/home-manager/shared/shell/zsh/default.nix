{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zsh
  ];

  programs.zsh = {
    enable = true;

    syntaxHighlighting = {
      enable = true;
    };

    # Load zoxide with cd override, but not in Claude Code shells.
    # Claude Code's shell snapshot captures the cd wrapper but filters
    # out the __zoxide_* functions it depends on, causing errors.
    initContent = ''
      if [[ -z "$CLAUDECODE" ]]; then
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh --cmd cd)"
      fi
    '';
  };

  # environment.pathsToLink = [ "/share/zsh" ];
}
