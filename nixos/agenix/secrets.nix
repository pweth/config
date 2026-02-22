/*
  * Used by the agenix CLI tool to know which public keys to use for encryption.
  * Not imported into the NixOS configuration.
*/
let
  keys = [
    (builtins.readFile ../../static/ed25519.pub)
  ] ++ builtins.attrValues (
    builtins.mapAttrs (name: key: key.age) (
      builtins.fromTOML (builtins.readFile ../../static/keys.toml)
    )
  );
  secrets = [
    "cloudflare.age"
    "grafana.age"
    "password-hash.age"
    "pweth.crt.age"
    "tailscale.age"
  ];
in
builtins.listToAttrs (map (name: {
  inherit name;
  value = { publicKeys = keys; };
}) secrets)
