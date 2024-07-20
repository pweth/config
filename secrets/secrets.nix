/*
* Used by the agenix CLI tool to know which public keys to use for encryption.
* Not imported into the NixOS configuration.
*/

let
  # Load in SSH keys
  hosts = builtins.mapAttrs (
    name: host: host.key
  ) (builtins.fromTOML (builtins.readFile ../attrs/hosts.toml));
  keys = builtins.mapAttrs (
    name: key: key.age
  ) (builtins.fromTOML (builtins.readFile ../attrs/keys.toml));

  # Secret to host mappings
  secrets = with keys; {
    # Common
    "certificate.age"   = builtins.attrValues hosts;
    "password-hash.age" = builtins.attrValues hosts;
    "tailscale.age"     = builtins.attrValues hosts;

    # Services
    "grafana.age"         = [ hosts.macaroni ];
    "masked-email.age"    = [ hosts.macaroni ];
    "paperless.age"       = [ hosts.humboldt ];
    "restic-emperor.age"  = [ hosts.emperor ];
    "restic-humboldt.age" = [ hosts.humboldt ];
  };
in
builtins.mapAttrs (name: hostKeys: {
  publicKeys = hostKeys ++ builtins.attrValues keys;
}) secrets
