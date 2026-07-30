{ username, ... }:
{
  imports = [
    ./karabiner
    ./macos-apps.nix
  ];

  home.homeDirectory = "/Users/${username}";
}
