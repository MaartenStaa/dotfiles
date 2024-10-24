_:
{
  # https://mynixos.com/home-manager/options/programs.starship
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./config.toml);
  };
}
