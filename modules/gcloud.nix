{ lib, pkgs, ... }:
with pkgs;
{
  home.packages = [
    google-cloud-sdk
  ];

  home.activation.gcloud-auth = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${google-cloud-sdk}/bin/gcloud auth configure-docker
  '';
}
