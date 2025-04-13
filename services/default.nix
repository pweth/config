# * Services configuration.

{ config, ...}:

{
  imports = [
    ./anki-sync.nix
    ./blocky.nix
    ./forgejo.nix
    ./grafana.nix
    ./immich.nix
    ./jellyfin.nix
    ./masked-email.nix
    ./prometheus.nix
  ];
}
