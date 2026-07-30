{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    fd
  ];

  xdg.configFile."fd" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/home-manager/fd/config";
  };
}
