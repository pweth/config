/*
* Used by the agenix CLI tool to know which public keys to use for encryption.
* Not imported into the NixOS configuration.
*/

let
  # Load in host information
  hosts = builtins.fromTOML (builtins.readFile ../hosts.toml);
  keys = builtins.mapAttrs (name: host: host.ed25519) hosts;
  master = builtins.readFile ../static/keys/age-primary.pub;

  # Secret to host mappings
  secrets = with keys; {
    "grafana.age"         = [ macaroni ];
    "nextdns.age"         = [ emperor humboldt macaroni magellanic rockhopper ];
    "paperless.age"       = [ humboldt ];
    "password-hash.age"   = [ emperor humboldt macaroni magellanic rockhopper ];
    "rclone.age"          = [ emperor ];
    "tailscale.age"       = [ emperor humboldt macaroni magellanic rockhopper ];
    "tunnel-humboldt.age" = [ humboldt ];
    "tunnel-macaroni.age" = [ macaroni ];
    "wifi.age"            = [ emperor ];
  };
in
builtins.mapAttrs (name: hostKeys: {
  publicKeys = hostKeys ++ [ master ];
}) secrets
