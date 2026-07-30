_: {
  # https://mynixos.com/home-manager/options/programs.zoxide
  programs.zoxide = {
    enable = true;
    # Zsh integration is handled manually in zsh/default.nix to skip
    # loading in Claude Code shells (which snapshot functions but filter
    # out __-prefixed ones, breaking the cd override).
    enableZshIntegration = false;
    options = [
      "--cmd cd"
    ];
  };
}
