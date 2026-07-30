{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./display.nix
    ./gaming.nix
    ./hardware-configuration.nix
    ./programs.nix
    ./wifi.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  networking.hostName = "maarten-pc";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  nix.settings = {
    extra-experimental-features = [
      "flakes"
      "nix-command"
    ];
  };

  system.stateVersion = "26.05";
}
