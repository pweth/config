/*
  * Used by the agenix CLI tool to know which public keys to use for encryption.
  * Not imported into the NixOS configuration.
*/

let
  # Load in SSH keys
  source = import ../census.nix;
  hosts = builtins.mapAttrs (name: host: host.ssh-key) source.hosts;
  keys = builtins.mapAttrs (name: key: key.age) source.keys;

  # Secret to host mappings
  secrets = with keys; {
    # Common
    "pweth.crt.age"     = builtins.attrValues hosts;
    "password-hash.age" = builtins.attrValues hosts;
    "tailscale.age"     = builtins.attrValues hosts;

    # Services
    "anki.age"         = [ hosts.humboldt ];
    "grafana.age"      = [ hosts.humboldt ];
    "masked-email.age" = [ hosts.humboldt ];
  };
in
builtins.mapAttrs (name: hostKeys: {
  publicKeys = hostKeys ++ builtins.attrValues keys;
}) secrets
