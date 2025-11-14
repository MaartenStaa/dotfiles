_: {
  # https://mynixos.com/home-manager/options/programs.starship
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./config.toml);
  };
}
