{ pkgs, ... }:
{
  catppuccin.ghostty.enable = true;

  programs.ghostty = {
    enable = true;
    installBatSyntax = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font Mono Light";

      command = "${pkgs.fish}/bin/fish --login --interactive";

      font-family-bold = "JetBrainsMono NFM Bold";
      font-family-italic = "JetBrainsMono NFM Light Italic";
      font-family-bold-italic = "JetBrainsMono NFM Bold Italic";

      font-size = 14;
      macos-option-as-alt = true;
      link-url = true;
    };
  };
}
