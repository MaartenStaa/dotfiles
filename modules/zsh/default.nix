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
  };

  # environment.pathsToLink = [ "/share/zsh" ];
}
