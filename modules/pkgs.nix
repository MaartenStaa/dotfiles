{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    with pkgs.luajitPackages;
    [
      # Command line tools
      ack
      ansifilter
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
      yazi

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
