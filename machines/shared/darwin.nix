{ pkgs, username, ... }:
{
  nix = {
    package = pkgs.nix;
    settings.trusted-users = [
      "root"
      username
    ];

    # Storage management on upgrades
    settings.auto-optimise-store = false;
  };

  system.stateVersion = 5;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    casks = [
      "aerospace"
      "alfred"
      "arc"
      "betterdisplay"
      "dash"
      "deskpad"
      "docker"
      "firefox@developer-edition"
      "ghostty"
      "home-assistant"
      "iina"
      "karabiner-elements"
      "kitty"
      "moom"
      "neovide"
      "sublime-merge"
      "sublime-text"
    ];
    masApps = {
      "Consent-O-Matic" = 1606897889;
      "Things 3" = 904280696;
    };
    global = {
      autoUpdate = false;
    };
    onActivation = {
      cleanup = "zap";
    };
  };

  # TODO: Add system defaults
  security = {
    pam.services.sudo_local.touchIdAuth = true;
  };
  system.primaryUser = username;
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.4;
    };
    finder = {
      AppleShowAllExtensions = true;
    };
  };
}
