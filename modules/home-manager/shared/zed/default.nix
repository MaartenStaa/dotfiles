{ config, ... }:
{
  xdg.configFile = {
    zed-keymap = {
      target = "zed/keymap.json";
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/home-manager/shared/zed/keymap.json";
    };
    zed-settings = {
      target = "zed/settings.json";
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/home-manager/shared/zed/settings.json";
    };
  };
}
