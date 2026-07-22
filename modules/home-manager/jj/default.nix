{
  arch,
  email,
  pkgs,
  oyui,
  ...
}:
{
  home.packages = with pkgs; [
    jujutsu
    lazyjj
    mergiraf
    oyui.packages.${arch}.default
  ];

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Maarten Staa";
        inherit email;
      };
      ui = {
        diff-editor = "oyui";
        diff-instructions = false;
        merge-editor = "mergiraf";
        editor = "nvim";
      };
      merge-tools.oyui = {
        program = "${oyui.packages.${arch}.default}/bin/oyui";
        edit-args = [
          "diff"
          "$left"
          "$right"
        ];
      };
    };
  };

  xdg.configFile.oyui = {
    source = ./oyui.rn;
    target = "oyui/config.rn";
  };
}
