{ ... }:
{
  # https://mynixos.com/home-manager/options/programs.zoxide
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };
}
