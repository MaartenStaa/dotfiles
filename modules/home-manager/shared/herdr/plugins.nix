{
  pkgs,
  inputs,
  ...
}:
let
  allSessions = [
    "default"
    "admin"
    "open-source"
  ];

  # Read herdr-plugin.toml from the source and merge with runtime paths.
  mkPlugin =
    {
      src,
      root,
      sessions ? allSessions,
    }:
    let
      manifest = builtins.fromTOML (builtins.readFile "${src}/herdr-plugin.toml");
    in
    {
      plugin_id = manifest.id;
      inherit (manifest)
        name
        version
        min_herdr_version
        description
        platforms
        ;
      actions = manifest.actions or [ ];
      panes = manifest.panes or [ ];
      events = manifest.events or [ ];
      manifest_path = "${root}/herdr-plugin.toml";
      plugin_root = "${root}";
      enabled = true;
      source = {
        kind = "local";
        path = "${root}";
      };
      _sessions = sessions;
    };

  # --- Plugin: herdr-plus (Go binary) ---
  herdr-plus-src = inputs.herdr-plugin-plus;

  herdr-plus-bin = pkgs.buildGoModule {
    pname = "herdr-plus";
    version = "0.1.16";
    src = herdr-plus-src;
    vendorHash = "sha256-im2gPhLarMf1w/8rhxbOe9EhUdvseffukT9tqU4EEXI=";
    doCheck = false;
  };

  herdr-plus-root = pkgs.runCommand "herdr-plus-plugin" { } ''
    mkdir -p $out/bin
    cp ${herdr-plus-bin}/bin/herdr-plus $out/bin/
    cp ${herdr-plus-src}/herdr-plugin.toml $out/
  '';

  # --- Plugin: herdr-command-palette (shell scripts, no build) ---
  command-palette-src = inputs.herdr-plugin-command-palette;

  command-palette-root = pkgs.runCommand "herdr-command-palette-plugin" { } ''
    cp -r ${command-palette-src} $out
    chmod -R u+w $out
    chmod +x $out/*.sh
  '';
in
[
  (mkPlugin {
    src = herdr-plus-src;
    root = herdr-plus-root;
  })
  (mkPlugin {
    src = command-palette-src;
    root = command-palette-root;
  })
]
