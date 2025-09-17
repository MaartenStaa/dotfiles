{ config, ... }:
{
  xdg.configFile = {
    zed-keymap = {
      target = "zed/keymap.json";
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/zed/keymap.json";
    };
    zed-settings = {
      target = "zed/settings.json";
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/zed/settings.json";
    };
  };
}
