{ pkgs, ... }:
{
  catppuccin.ghostty.enable = true;

  programs.ghostty = {
    enable = true;
    # ghostty installation is broken on macOS; let home manager handle configuration,
    # but not installation by setting a null package
    package = null;
    enableFishIntegration = true;
    # requires a package set
    # installBatSyntax = true;
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
