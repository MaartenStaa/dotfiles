{ pkgs, ... }:
{
  imports = [
    ./fish
    ./zsh
    ./bat.nix
  ];

  programs.zoxide.enable = true;
  # environment.shells = [ pkgs.fish ];
}
