/*
  * Used by the agenix CLI tool to know which public keys to use for encryption.
  * Not imported into the NixOS configuration.
*/

let
  # Load in SSH keys
  hosts = builtins.mapAttrs (name: host: "ssh-ed25519 ${host.ssh-key}") (
    builtins.fromTOML (builtins.readFile ../attrs/hosts.toml)
  );
  keys = builtins.mapAttrs (name: key: key.age) (
    builtins.fromTOML (builtins.readFile ../attrs/keys.toml)
  );

  # Secret to host mappings
  secrets = with keys; {
    # Common
    "certificate.age"   = builtins.attrValues hosts;
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
