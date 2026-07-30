{ pkgs, ... }: {
  services = {
    xserver.enable = true;
    xserver.xkb.layout = "us";
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  programs.dconf.enable = true;
  qt.enable = true;
  qt.platformTheme = "kde";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    gnome-themes-extra
  ];
}
