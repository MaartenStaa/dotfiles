{ username, inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin

    ./bat.nix
    ./catppuccin.nix
    ./claude.nix
    ./development.nix
    ./fd
    ./fzf.nix
    ./ghostty
    ./git
    ./herdr
    ./jj
    ./kitty
    ./mcp.nix
    ./neovim
    ./opencode.nix
    ./pkgs.nix
    ./python.nix
    ./shell
    ./tmux
    ./zed
    ./zoxide.nix
  ];

  home = {
    inherit username;
    stateVersion = "24.05";
    enableNixpkgsReleaseCheck = false;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.nix-index.enable = true;
}
