{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    discord
    heroic
  ];

  services.sunshine = {
    enable = true;
    openFirewall = true;
  };
}
