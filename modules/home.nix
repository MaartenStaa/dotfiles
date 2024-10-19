{ username, ... }:
{
  home.username = username;
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # programs.nix-index.enable = true;
}
