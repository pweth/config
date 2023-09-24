/*
* Used by the agenix CLI tool to know which public keys to use for encryption.
* Not imported into the NixOS configuration.
*/

let
  # Personal keys
  personal = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN2LcPpOlnOwQ67Xp6uJnuOmDj0W06Bzyr73l6xkZgtg primary@pweth.com"
  ];

  # Host keys
  emperor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqt+SLcA0kXPLvuF+mogzId9n57rB5y0PyWJ8RE0ja8 root@emperor";
  macaroni = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDs6W94lN0Kx8hOEU4BArPlzkishQGQDVD/gLEsncAzI root@macaroni";
  rockhopper = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDw/Rhr1cdwp3RIwmxTWBa1tWA3gzMyyC8YTJNMN0Fbf root@rockhopper";
in
{
  "ackee-password.age".publicKeys = personal ++ [ macaroni ];
  "cloudflare-api.age".publicKeys = personal ++ [ macaroni ];
  "grafana-password.age".publicKeys = personal ++ [ macaroni ];
  "password-hash.age".publicKeys = personal ++ [ emperor macaroni rockhopper ];
}
