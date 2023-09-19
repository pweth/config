/*
* Used by the agenix CLI tool to know which public keys to use for encryption.
* Not imported into the NixOS configuration.
*/

let
  # Personal keys
  primary = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN2LcPpOlnOwQ67Xp6uJnuOmDj0W06Bzyr73l6xkZgtg primary@pweth.com";

  # Host keys
  emperor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqt+SLcA0kXPLvuF+mogzId9n57rB5y0PyWJ8RE0ja8 root@emperor";
  macaroni = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDs6W94lN0Kx8hOEU4BArPlzkishQGQDVD/gLEsncAzI root@macaroni";
in
{
  "cloudflare-api.age".publicKeys = [ primary macaroni ];
  "password-hash.age".publicKeys = [ primary emperor macaroni ];
  "radicale-configuration.age".publicKeys = [ primary macaroni ];
  "radicale-users.age".publicKeys = [ primary macaroni ];
}
