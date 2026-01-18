# * Services configuration.

{ config, ...}:

{
  imports = [
    ./forgejo.nix
    ./grafana.nix
    ./immich.nix
    ./jellyfin.nix
    ./prometheus.nix
    ./usenet.nix
  ];
}
