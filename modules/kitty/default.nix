{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    environment = {
      SHELL = "${pkgs.fish}/bin/fish";
    };
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 14;
    };
    settings = {
      enabled_layouts = "all";

      tab_bar_style = "powerline";
      tab_powerline_style = "round";

      shell = "${pkgs.fish}/bin/fish --login --interactive";
      editor = "${pkgs.neovim}/bin/nvim";

      term = "tmux-256color";
      shell_integration = true;

      macos_option_as_alt = true;

      cursor_trail = 10;
      cursor_trail_start_threshold = 2;
      cursor_trail_decay = "0.1 0.4";
    };
    shellIntegration = {
      enableFishIntegration = true;
    };
    themeFile = "Catppuccin-Macchiato";
  };
}
