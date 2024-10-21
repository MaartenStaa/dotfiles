{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    with pkgs.python312Packages;
    with pkgs.luajitPackages;
    [
      # Command line tools
      ack
      bat
      coreutils
      curl
      diff-so-fancy
      exiftool
      eza
      ffmpeg
      gnupg
      htop
      inetutils
      jq
      neovim-remote
      proximity-sort
      reattach-to-user-namespace
      ripgrep
      silver-searcher
      tldr
      tree
      tmux
      wget

      # General software development
      cloc
      snyk

      # Smart home
      esptool

      # GUI applications
      # karabiner-elements
      kitty
      obsidian
      slack
    ];

  fonts.fontconfig.enable = true;
}
