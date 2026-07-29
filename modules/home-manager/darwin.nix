{ username, pkgs, ... }:
{
  home.homeDirectory = "/Users/${username}";

  home.packages = with pkgs; [
    reattach-to-user-namespace

    # Window management
    aerospace
    jankyborders
  ];
}
