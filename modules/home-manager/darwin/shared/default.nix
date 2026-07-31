{ username, ... }:
{
  imports = [
    ./karabiner
    ./macos-apps.nix
    ./mcp.nix
  ];

  home.homeDirectory = "/Users/${username}";
}
