{ pkgs, ... }:
{
  # Allow running of proprietary software (e.g. Obsidian)
  nixpkgs.config.allowUnfree = true;

  # TODO: This doesn't work on macOS
  services.nix-daemon.enable = true;
  nix.useDaemon = true;
  nix.package = pkgs.nix;
  nix.settings.trusted-users = [
    "root"
    "maartens"
  ];
  system.stateVersion = 5;

  # Storage management on upgrades
  nix.gc.automatic = true;
  nix.settings.auto-optimise-store = false;

  users.users.maartens = {
    name = "maartens";
    home = "/Users/maartens";
  };

  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    casks = [
      "alfred"
      "arc"
      "betterdisplay"
      "dash"
      "deskpad"
      "docker"
      "firefox@developer-edition"
      "karabiner-elements"
      "home-assistant"
      "iina"
      "moom"
      "aerospace"
      "sublime-merge"
      "sublime-text"
      "todoist"
    ];
    masApps = {
      "Consent-O-Matic" = 1606897889;
    };
    global = {
      autoUpdate = false;
    };
    onActivation = {
      cleanup = "zap";
    };
  };

  # TODO: Add system defaults
}
