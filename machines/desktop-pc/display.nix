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

  # Workaround for missing fonts in Firefox
  # See: https://github.com/nixos/nixpkgs/issues/546204
  environment.sessionVariables.XDG_DATA_DIRS = [
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  ];

}
