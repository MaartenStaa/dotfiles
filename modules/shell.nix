{ pkgs, ... }: {
  imports = [
    ./fish
    ./bat.nix
  ];

  programs.zoxide.enable = true;
  # environment.shells = [ pkgs.fish ];
}
