{ pkgs, username, ... }:
{
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    clang
  ];
}
