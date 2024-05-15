/*
* Used by the agenix CLI tool to know which public keys to use for encryption.
* Not imported into the NixOS configuration.
*/

let
  # Load in host information
  hosts = builtins.fromTOML (builtins.readFile ../hosts.toml);
  keys = builtins.mapAttrs (name: host: builtins.readFile (../keys/ssh + "/${name}.pub")) hosts;
  masters = [
    (builtins.readFile ../keys/age/igneous.pub)
    (builtins.readFile ../keys/age/metamorphic.pub)
    (builtins.readFile ../keys/age/sedimentary.pub)
  ];

  # Secret to host mappings
  secrets = with keys; {
    # Common
    "home-arpa-key.age" = builtins.attrValues keys;
    "password-hash.age" = builtins.attrValues keys;
    "tailscale.age"     = builtins.attrValues keys;

    # GUI
    "localhost-key.age"   = [ emperor ];

    # Services
    "dns-01.age"          = [ humboldt ];
    "flatnotes.age"       = [ humboldt ];
    "grafana.age"         = [ humboldt ];
    "masked-email.age"    = [ humboldt ];
    "paperless.age"       = [ humboldt ];
    "restic-emperor.age"  = [ emperor ];
    "restic-humboldt.age" = [ humboldt ];
  };
in
builtins.mapAttrs (name: hostKeys: {
  publicKeys = hostKeys ++ masters;
}) secrets
