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
      fd
      ffmpeg
      gnupg
      htop
      inetutils
      jq
      neovim-remote
      reattach-to-user-namespace
      ripgrep
      silver-searcher
      tldr
      tree
      tmux
      wget
      zoxide
      zsh

      # General software development
      cloc
      google-cloud-sdk
      snyk

      # Smart home
      esptool

      # GUI applications
      # karabiner-elements
      kitty
      obsidian
      slack

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

  fonts.fontconfig.enable = true;
}
