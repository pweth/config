# * Services configuration.

{ config, ...}:

{
  imports = [
    ./forgejo.nix
    ./grafana.nix
    ./immich.nix
    ./jellyfin.nix
    ./masked-email.nix
    ./minecraft.nix
    ./prometheus.nix
    ./usenet.nix
  ];
}
