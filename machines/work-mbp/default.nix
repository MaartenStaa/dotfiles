{ ... }:
{
  imports = [
    ../shared/darwin.nix
  ];

  homebrew = {
    brews = [
      "jira-cli"
    ];
  };
}
