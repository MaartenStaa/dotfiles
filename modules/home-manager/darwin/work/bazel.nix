{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bazelisk
  ];
  home.shellAliases = {
    bazel = "bazelisk";
  };
}
