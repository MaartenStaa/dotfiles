{ ... }: {
  # TODO: Parameterize this
  home.homeDirectory = "/Users/maartens";

  catppuccin = {
    enable = true;
    flavor = "macchiato";
  };
}
