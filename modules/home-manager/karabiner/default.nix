{ config, ... }:
{
  xdg.configFile."karabiner" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/home-manager/karabiner/config";
  };
}
