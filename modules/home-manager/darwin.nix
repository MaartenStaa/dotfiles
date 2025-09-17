{ username, ... }:
{
  home.homeDirectory = "/Users/${username}";

  catppuccin = {
    enable = true;
    flavor = "macchiato";
  };
}
