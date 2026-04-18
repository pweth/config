/*
  * Used by the agenix CLI tool to know which public keys to use for encryption.
  * Not imported into the NixOS configuration.
*/
let
  keys = [
    # Host key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIALl6nmhTzqES2qmootEZ6x8DuomSvJCzYTormEevq4y"
    # Sedimentary
    "age1yubikey1q0sd4yd3t4e2jarc2xmufzkhryf42nrelrpagy24jq4suddqumkhzqy526m"
  ];
  secrets = [
    "cloudflare.age"
    "grafana.age"
    "password-hash.age"
  ];
in
builtins.listToAttrs (
  map (name: {
    inherit name;
    value = {
      publicKeys = keys;
    };
  }) secrets
)
