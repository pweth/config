/*
* Public key file configuration.
*/

{ config, keys, ... }:

{
  # Create age and SSH public key files
  home.file = builtins.listToAttrs (builtins.concatLists (builtins.attrValues (builtins.mapAttrs (
    name: key: [
      { name = ".age/${name}.identity"; value.text = key.identity; }
      { name = ".age/${name}.pub"; value.text = key.age; }
      { name = ".ssh/${name}.pub"; value.text = key.ssh; }
    ]
  ) keys)));
}
