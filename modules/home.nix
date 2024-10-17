{ ... }: {
  # TODO: Parameterize this.
  home.username = "maartens";
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # programs.nix-index.enable = true;
}
