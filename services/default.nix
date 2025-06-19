# * Services configuration.

{ config, ...}:

{
  imports = [
    ./blocky.nix
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
