{ pkgs, ... }: {
  programs = {
    _1password-gui.enable = true;
    firefox.enable = true;
    fish.enable = true;
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    ghostty
    gnome-themes-extra
    vim
    wget
    zsh
  ];
}
