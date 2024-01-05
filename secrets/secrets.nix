/*
* Used by the agenix CLI tool to know which public keys to use for encryption.
* Not imported into the NixOS configuration.
*/

let
  emperor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqt+SLcA0kXPLvuF+mogzId9n57rB5y0PyWJ8RE0ja8 root@emperor";
  macaroni = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDs6W94lN0Kx8hOEU4BArPlzkishQGQDVD/gLEsncAzI root@macaroni";
  rockhopper = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDw/Rhr1cdwp3RIwmxTWBa1tWA3gzMyyC8YTJNMN0Fbf root@rockhopper";
in
{
  "cloudflare.age".publicKeys = [ macaroni ];
  "grafana.age".publicKeys = [ macaroni ];
  "jupyter.age".publicKeys = [ macaroni ];
  "nextdns.age".publicKeys = [ emperor macaroni rockhopper ];
  "password-hash.age".publicKeys = [ emperor macaroni rockhopper ];
  "rclone.age".publicKeys = [ emperor ];
  "wifi.age".publicKeys = [ emperor ];
}
