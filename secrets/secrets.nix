/*
* Used by the agenix CLI tool to know which public keys to use for encryption.
* Not imported into the NixOS configuration.
*/

let
  # Load in host information
  hosts = builtins.fromTOML (builtins.readFile ../hosts.toml);
  keys = builtins.mapAttrs (name: host: host.ed25519) hosts;
  masters = [
    (builtins.readFile ../static/keys/age-primary.pub)
    (builtins.readFile ../static/keys/age-secondary.pub)
  ];

  # Secret to host mappings
  secrets = with keys; {
    # Common
    "home-arpa-key.age" = builtins.attrValues keys;
    "nextdns.age"       = builtins.attrValues keys;
    "password-hash.age" = builtins.attrValues keys;
    "tailscale.age"     = builtins.attrValues keys;

    # Services
    "dns-01.age"          = [ humboldt ];
    "flatnotes.age"       = [ humboldt ];
    "grafana.age"         = [ humboldt ];
    "paperless.age"       = [ humboldt ];
    "restic-emperor.age"  = [ emperor ];
    "restic-humboldt.age" = [ humboldt ];
    "tunnel-humboldt.age" = [ humboldt ];
    "tunnel-macaroni.age" = [ macaroni ];
  };
in
builtins.mapAttrs (name: hostKeys: {
  publicKeys = hostKeys ++ masters;
}) secrets
