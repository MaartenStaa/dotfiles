{ ... }:
{
  imports = [
    ../shared/darwin.nix
  ];

  homebrew = {
    brews = [
      "sptcli"
    ];
  };
}
